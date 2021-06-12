import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()
installer = '%s/neva' % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
class Neovim(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'neva'
        self._install_cmds = ['%s uninstall' % installer,
                              '%s install' % installer, '%s clean' % installer]
        super(Neovim, self).__init__(context)
