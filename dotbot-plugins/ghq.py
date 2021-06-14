import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
class Ghq(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'ghq'
        self._install_cmds = ['ghq get [flags] [package]']
        super(Ghq, self).__init__(context)
