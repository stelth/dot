import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
class Lua(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'luarocks'
        self._install_cmds = ['luarocks install --server=https://luarocks.org/dev']
        self._list_cmd = 'luarocks list'
        super(Lua, self).__init__(context)
