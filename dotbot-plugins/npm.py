import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


class Npm(package.HandlerMixin, package.InstallMixin, package.UpdateMixin, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'npm'
        self._install_cmd = 'npm install'
        self._list_cmd = 'npm list'
        self._update_cmds = ['npm update']
        super(Npm, self).__init__(context)
