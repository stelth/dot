import os
import subprocess
import dotbot


class Packages(dotbot.Plugin):
    _directive = "package"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Packages cannot handle directive %s' % directive)

        log = self._log
        defaults = self._context._defaults.get('package', {})
        for package_manager, options in data.items():
            install_cmd = defaults.get('installCmd', '')
            list_cmd = defaults.get('listCmd', '')
            update_cmds = defaults.get('updateCmds', [])
            clean_cmd = defaults.get('cleanCmd', '')
            test = defaults.get('if', '')

            if isinstance(options, dict):
                install_cmd = options.get('installCmd', install_cmd)
                list_cmd = options.get('listCmd', list_cmd)
                update_cmds = options.get('updateCmds', update_cmds)
                clean_cmd = options.get('cleanCmd', clean_cmd)
                test = options.get('if', test)

            if test and not self._test_success(test):
                log.lowinfo('Skipping %s' % package_manager)
                continue

            packages = options['packages']
            if install_cmd:
                if not self._install(install_cmd, list_cmd, packages):
                    log.error(
                        '[%s] Some packages were not installed' % package_manager)
                    return False

            if update_cmds:
                if not self._update(update_cmds):
                    log.error(
                        '[%s] Some packages were not updated' % package_manager)
                    return False

            if clean_cmd:
                if not self._clean(clean_cmd):
                    log.error(
                        '[%s] Some packages couldn\'t be cleaned' % package_manager)
                    return False

            log.info('All packages processed for %s' % package_manager)

        return True

    def _install(self, install_cmd, list_cmd, packages_list):
        log = self._log
        for package in packages_list:
            is_installed_cmd = "%s | grep %s" % (list_cmd, package)
            is_installed = self._shell_command(is_installed_cmd, cwd=self._context.base_directory())
            if is_installed != 0:
                log.info("Installing %s" % package)
                cmd = "%s %s" % (install_cmd, package)
                result = self._shell_command(cmd, cwd=self._context.base_directory())
                if result != 0:
                    log.error('Failed to install [%s]' % package)
                    return False
        return True

    def _update(self, update_cmds):
        log = self._log
        for cmd in update_cmds:
            success = self._shell_command(cmd, cwd=self._context.base_directory())
            if success != 0:
                log.error('Command [%s] failed to run' % cmd)
                return False

        return True

    def _clean(self, clean_cmd):
        return True

    def _shell_command(self, command, cwd):
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            return subprocess.call(command, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)

    def _test_success(self, command):
        ret = self._shell_command(command, cwd=self._context.base_directory())
        if ret != 0:
            self._log.debug('Test \'%s\' returned false' % command)

        return ret == 0
