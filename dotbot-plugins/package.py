import dotbot

import imp
import pathlib
path = "%s/handler.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
@package.updateable
class Package(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'package'
        self._install_cmds = []
        self._list_cmd = ''
        self._update_cmds = []
        super(Package, self).__init__(context)
