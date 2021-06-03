import os
import subprocess
import dotbot


class Pip(dotbot.Plugin):
    _directive = "pip"
    _pipInstallCommand = "pip3 install --user"
    _pipIsInstalledCommand = "pip3 list --user | grep %s"

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
        cwd = self._context.base_directory()
        log = self._log
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            for package in packages_list:
                cmd = self._pipIsInstalledCommand % package
                isInstalled = subprocess.call(
                    cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
                if isInstalled != 0:
                    log.info("Installing %s" % package)
                    cmd = "%s %s" % (self._pipInstallCommand, package)
                    result = subprocess.call(cmd, shell=True, cwd=cwd)
                    if result != 0:
                        log.warning('Failed to install [%s]' % package)
                        return False
            return True
