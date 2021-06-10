import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)

@package.updateable
class Neovim(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'neovim'
        super(Neovim, self).__init__(context)
