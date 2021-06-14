import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
@package.updateable
class Npm(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'npm'
        self._install_cmds = ['npm install [flags] [package]']
        self._list_cmd = 'npm list [flags] [package]'
        self._update_cmds = ['npm update']
        super(Npm, self).__init__(context)
