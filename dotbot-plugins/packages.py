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
            install = defaults.get('install', True)
            install_cmd = defaults.get('installCmd', '')
            list_cmd = defaults.get('listCmd', '')
            update = defaults.get('update', False)
            update_cmds = defaults.get('updateCmds', [])
            clean = defaults.get('clean', False)
            clean_cmd = defaults.get('cleanCmd', '')

            if isinstance(options, dict):
                install = options.get('install', install)
                install_cmd = options.get('installCmd', install_cmd)
                list_cmd = options.get('listCmd', list_cmd)
                update = options.get('update', update)
                update_cmds = options.get('updateCmds', update_cmds)
                clean = options.get('clean', clean)
                clean_cmd = options.get('cleanCmd', clean_cmd)

            packages = options['packages']
            if install:
                if not self._install(install_cmd, list_cmd, packages):
                    log.error(
                        '[%s] Some packages were not installed' % package_manager)
                    return False

            if update:
                if not self._update(update_cmds):
                    log.error(
                        '[%s] Some packages were not updated' % package_manager)
                    return False

            if clean:
                if not self._clean(clean_cmd):
                    log.error(
                        '[%s] Some packages couldn\'t be cleaned' % package_manager)
                    return False

            log.info('All packages processed for %s' % package_manager)

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

    def _update(self, update_cmds):
        cwd = self._context.base_directory()
        log = self._log
        with open(os.devnull, 'w') as devnull:
            stdin = stdout = stderr = devnull
            for cmd in update_cmds:
                success = subprocess.call(
                    cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd)
                if success != 0:
                    log.error('Command [%s] failed to run' % cmd)
                    return False

        return True

    def _clean(self, clean_cmd):
        return True
