import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
@package.updateable
class Cargo(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'cargo'
        self._install_cmds = ['cargo install [flags] [package]']
        self._list_cmd = 'cargo install [flags] --list | grep [package]'
        self._update_cmds = ['cargo install-update -a']
        super(Cargo, self).__init__(context)
