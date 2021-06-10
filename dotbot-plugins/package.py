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

        if hasattr(self, '_install_cmd') and hasattr(self, '_list_cmd'):
            for package_name, options in data.items():
                flags = self._defaults.get('flags', '')
                test = self._defaults.get('if', '')

                if isinstance(options, dict):
                    flags = options.get('flags', flags)
                    test = options.get('if', test)

                if test and not self._test_success(test):
                    log.lowinfo('Skipping %s' % package_name)
                    continue

                self._install_cmd = "%s %s" % (
                    self._install_cmd, " ".join(flags))
                self._list_cmd = "%s %s" % (self._list_cmd, " ".join(flags))

                if not self._install(package_name):
                    log.error(
                        '[%s] Some packages were not installed' % self._directive)
                    return False

        if hasattr(self, '_update_cmds'):
            if not self._update():
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

    def _shell_command(self, command, cwd):
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            return subprocess.call(command, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)

    def _test_success(self, command):
        ret = self._shell_command(command, cwd=self._context.base_directory())
        if ret != 0:
            self._log.debug('Test \'%s\' returned false' % command)

        return ret == 0


class InstallMixin(object):
    def _install(self, package):
        list_cmd = self._list_cmd
        install_cmd = self._install_cmd
        log = self._log
        is_installed_cmd = "%s | grep %s" % (list_cmd, package)
        is_installed = self._shell_command(
            is_installed_cmd, cwd=self._context.base_directory())
        if is_installed != 0:
            log.info("Installing %s" % package)
            cmd = "%s %s" % (install_cmd, package)
            result = self._shell_command(
                cmd, cwd=self._context.base_directory())
            if result != 0:
                log.error('Failed to install [%s]' % package)
                return False
        else:
            log.lowinfo('%s already installed' % package)

        return True


class UpdateMixin(object):
    def _update(self):
        log = self._log
        flags = self._defaults.get('flags', '')
        test = self._defaults.get('if', '')
        if test and not self._test_success(test):
            log.lowinfo('Skipping update for %s' % self._directive)
            return True

        update_cmds = self._update_cmds
        for cmd in update_cmds:
            cmd = "%s %s" % (cmd, " ".join(flags))
            success = self._shell_command(
                cmd, cwd=self._context.base_directory())
            if success != 0:
                log.error('Command [%s] failed to run' % cmd)
                return False

        return True


class CleanMixin(object):
    def _clean(self):
        return True
