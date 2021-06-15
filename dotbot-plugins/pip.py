import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


@package.installable
@package.updateable
class Pip(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'pip'
        self._install_cmds = ['pip3 install [flags] [package]']
        self._list_cmd = 'pip3 list [flags] | grep [package]'
        self._update_cmds = ['pip3 freeze --local [flags] | grep -v \'^-e\' | cut -d = -f 1 | xargs -n1 pip3 install -U [flags]']
        super(Pip, self).__init__(context)
