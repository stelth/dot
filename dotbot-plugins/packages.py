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

        defaults = self._context._defaults.get('packages', {})
        for packageManager, options in data.items():
            install = defaults.get('install', True)
            install_cmd = defaults.get('installCmd', '')
            list_cmd = defaults.get('listCmd', '')
            update = defaults.get('update', False)
            update_cmd = defaults.get('updateCmd', '')
            clean = defaults.get('clean', False)
            clean_cmd = defaults.get('cleanCmd', '')
            if isinstance(options, dict):
                install = options.get('install', install)
                install_cmd = options.get('installCmd', install_cmd)
                list_cmd = options.get('listCmd', list_cmd)
                update = options.get('update', update)
                update_cmd = options.get('updateCmd', update_cmd)
                clean = options.get('clean', clean)
                clean_cmd = options.get('cleanCmd', clean_cmd)

            packages = options['packages']
            if install != '':
                if not self._install(install_cmd, list_cmd, packages):
                    self._log.error(
                        '[%s] Some packages were not installed' % packageManager)
                    return False

            if update:
                if not self._update(update_cmd):
                    self._log.error(
                        '[%s] Some packages were not updated' % packageManager)
                    return False

            if clean:
                if not self._clean(clean_cmd):
                    self._log.error(
                        '[%s] Some packages couldn\'t be cleaned' % packageManager)
                    return False

        self._log.info('All packages processed')
        return True

    def _install(self, install_cmd, list_cmd, packages_list):
        cwd = self._context.base_directory()
        log = self._log
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            for package in packages_list:
                is_installed_cmd = "%s | grep %s" % (list_cmd, package)
                is_installed = subprocess.call(
                    is_installed_cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
                if is_installed != 0:
                    log.info("Installing %s" % package)
                    cmd = "%s %s" % (install_cmd, package)
                    result = subprocess.call(
                        cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
                    if result != 0:
                        log.error('Failed to install [%s]' % package)
                        return False
            return True

    def _update(self, update_cmd):
        cwd = self._context.base_directory()
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            update_succeeded = subprocess.call(
                update_cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
            return update_succeeded == 0

        return True

    def _clean(self, clean_cmd):
        return True
