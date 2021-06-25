import dotbot

import os
import subprocess


class PackageHandler(dotbot.Plugin):
    def __init__(self, context):
        self._directives = ['package']
        super(PackageHandler, self).__init__(context)

    def can_handle(self, directive):
        defaults = self._context._defaults.get('packageHandler', {})
        self._directives.extend(defaults.get('managers', []))

        return directive in self._directives

    def handle(self, directive, data):
        if directive not in self._directives:
            raise ValueError('Packages cannot handle directive %s' % directive)

        log = self._log

        if not self.install(directive, data):
            log.error(
                '[%s] Some packages were not installed' % directive)
            return False

        if not self.update(directive, data):
            log.error(
                '[%s] Some packages were not updated' % directive)
            return False

        if not self.clean(directive, data):
            log.error(
                '[%s] Some packages couldn\'t be cleaned' % directive)
            return False

        log.info('All packages processed for %s' % directive)

        return True

    def _shell_command(self, command):
        self._log.debug('Running command: %s' % command)
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            return subprocess.call(command, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=self._context.base_directory())

    def _test_success(self, command):
        ret = self._shell_command(command)
        if ret != 0:
            self._log.debug('Test \'%s\' returned false' % command)

        return ret == 0

    def _construct_command(self, base_command, flags, package_name):
        cmd = base_command.replace('[flags]', ' '.join(flags))
        cmd = cmd.replace('[package]', package_name)

        return cmd

    def install(self, directive, data):
        log = self._log
        defaults = self._context._defaults.get(directive, {})
        for package_name, options in data.items():
            flags = defaults.get('flags', '')
            test = defaults.get('if', '')
            install_cmds = defaults.get(
                'installCmds', [])
            list_cmd = defaults.get('listCmd', '')

            if isinstance(options, dict):
                flags = options.get('flags', flags)
                test = options.get('if', test)
                install_cmds = options.get('installCmds', install_cmds)
                list_cmd = options.get('listCmd', list_cmd)

            package_options = {
                'package_name': package_name,
                'flags': flags,
                'test': test,
                'install_cmds': install_cmds,
                'list_cmd': list_cmd
            }

            if test and not self._test_success(test):
                log.lowinfo('Skipping install of %s' % package_name)
                continue

            if self.is_installed(package_options):
                log.lowinfo('%s already installed' % package_name)
                continue

            if not self.do_installation(package_options):
                log.error('Failed to install %s' % package_name)
                return False

            log.lowinfo('Installed %s' % package_name)

        return True

    def is_installed(self, package_options):
        package_name = package_options['package_name']
        flags = package_options['flags']
        list_cmd = package_options['list_cmd']

        if not list_cmd:
            return False

        is_installed_cmd = self._construct_command(
            list_cmd, flags, package_name)
        return self._shell_command(is_installed_cmd) == 0

    def do_installation(self, package_options):
        package_name = package_options['package_name']
        flags = package_options['flags']
        install_cmds = package_options['install_cmds']

        for cmd in install_cmds:
            cmd = self._construct_command(cmd, flags, package_name)
            result = self._shell_command(cmd)
            if result != 0:
                return False

        return True

    def update(self, directive, data):
        defaults = self._context._defaults.get(directive, {})
        log = self._log

        for package_name, options in data.items():
            test = defaults.get('if', '')
            flags = defaults.get('flags', [])
            update_cmds = []

            if isinstance(options, dict):
                flags = options.get('flags', flags)
                test = options.get('if', test)
                update_cmds = options.get('updateCmds', update_cmds)

            if test and not self._test_success(test):
                log.lowinfo('Skipping update of %s' % package_name)
                continue

            if not update_cmds:
                continue

            for cmd in update_cmds:
                cmd = self._construct_command(cmd, flags, package_name)
                if self._shell_command(cmd) != 0:
                    log.error('Command [%s] failed to run' % cmd)
                    return False

            log.lowinfo('Updated %s' % package_name)

        # process global update cmds
        flags = defaults.get('flags', [])
        test = defaults.get('if', '')
        update_cmds = defaults.get('updateCmds', [])

        if test and not self._test_success(test):
            log.lowinfo('Skipping global update of %s' % directive)
            return True

        for cmd in update_cmds:
            cmd = self._construct_command(cmd, flags, '')
            if self._shell_command(cmd) != 0:
                log.error('Command [%s] failed to run' % cmd)
                return False

        log.lowinfo('Globally updated %s' % directive)

        return True

    def clean(self, directive, data):
        return True
