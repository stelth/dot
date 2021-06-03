import os
import platform
import subprocess
import dotbot


class Npm(dotbot.Plugin):
    _installCommand = "npm install -g"
    _isInstalledCommand = "npm list -g | grep"
    _directive = "npm"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive == self._directive:
            return self._process_data(data)
        raise ValueError('Pip cannot handle directive %s' % directive)

    def _process_data(self, data):
        success = self._install(data)
        if success:
            self._log.info('All packages have been installed')
        else:
            self._log.error('Some packages were not installed')
        return success

    def _install(self, packages_list):
        if platform.system() != "Darwin" and platform.system() != "Linux":
            return True

        if platform.system() == "Linux" and os.getuid() != 0:
            return True

        cwd = self._context.base_directory()
        log = self._log
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            for package in packages_list:
                cmd = "%s %s" % (self._isInstalledCommand, package)
                isInstalled = subprocess.call(
                    cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
                if isInstalled != 0:
                    log.info("Installing %s" % package)
                    cmd = "%s %s" % (self._installCommand, package)
                    result = subprocess.call(cmd, shell=True, cwd=cwd)
                    if result != 0:
                        log.warning('Failed to install [%s]' % package)
                        return False
            return True
