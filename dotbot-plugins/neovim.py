import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


class Neovim(package.HandlerMixin, package.UpdateMixin, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'neovim'
        self._update_cmds = []
        super(Neovim, self).__init__(context)
