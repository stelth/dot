import dotbot

import imp
import pathlib
path = "%s/handler.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
class Lua(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'luarocks'
        self._install_cmds = ['luarocks install [flags] [package]']
        self._list_cmd = 'luarocks list [flags] | grep [package]'
        super(Lua, self).__init__(context)
