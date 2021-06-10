import os
import subprocess


class HandlerMixin(object):
    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Packages cannot handle directive %s' % directive)

        log = self._log
        self._defaults = self._context._defaults.get(self._directive, {})

        if hasattr(self, '_install_cmds'):
            if not self.install(data):
                log.error(
                    '[%s] Some packages were not installed' % self._directive)
                return False

        if hasattr(self, '_update_cmds'):
            if not self.update(data):
                log.error(
                    '[%s] Some packages were not updated' % self._directive)
                return False

        if hasattr(self, '_clean_cmd'):
            if not self._clean():
                log.error(
                    '[%s] Some packages couldn\'t be cleaned' % self._directive)
                return False

        log.info('All packages processed for %s' % self._directive)

        return True

    def _shell_command(self, command):
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            return subprocess.call(command, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=self._context.base_directory())

    def _test_success(self, command):
        ret = self._shell_command(command)
        if ret != 0:
            self._log.debug('Test \'%s\' returned false' % command)

        return ret == 0


class InstallMixin(object):
    def install(self, data):
        log = self._log
        for package_name, options in data.items():
            flags = self._defaults.get('flags', '')
            test = self._defaults.get('if', '')
            install_cmds = self._defaults.get(
                'installCmds', self._install_cmds)

            if isinstance(options, dict):
                flags = options.get('flags', flags)
                test = options.get('if', test)
                install_cmds = options.get('installCmds', install_cmds)

            package_options = {
                    'package_name': package_name,
                    'flags': flags,
                    'test': test,
                    'install_cmds': install_cmds
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
        if not hasattr(self, '_list_cmd'):
            return False

        package_name = package_options['package_name']
        flags = package_options['flags']
        is_installed_cmd = '%s %s | grep %s' % (self._list_cmd, " ".join(flags), package_name)
        return self._shell_command(is_installed_cmd) == 0

    def do_installation(self, package_options):
        package_name = package_options['package_name']
        flags = package_options['flags']
        install_cmds = package_options['install_cmds']

        for cmd in install_cmds:
            cmd = "%s %s %s" % (cmd, " ".join(flags), package_name)
            result = self._shell_command(cmd)
            if result != 0:
                return False

        return True


class UpdateMixin(object):
    def update(self, data):
        log = self._log

        for package_name, options in data.items():
            test = self._defaults.get('if', '')
            update_cmds = []

            if isinstance(options, dict):
                flags = options.get('flags', '')
                test = options.get('if', '')
                update_cmds = options.get('updateCmds', update_cmds)

            if test and not self._test_success(test):
                log.lowinfo('Skipping update of %s' % package_name)
                continue

            if not update_cmds:
                continue

            for cmd in update_cmds:
                if self._shell_command(cmd) != 0:
                    log.error('Command [%s] failed to run' % cmd)
                    return False

            log.lowinfo('Updated %s' % package_name)

        # process global update cmd
        update_cmds = self._update_cmds
        for cmd in update_cmds:
            cmd = "%s %s" % (cmd, " ".join(flags))
            if self._shell_command(cmd) != 0:
                log.error('Command [%s] failed to run' % cmd)
                return False

        log.lowinfo('Updated %s' % self._directive)

        return True


class CleanMixin(object):
    def _clean(self):
        return True
