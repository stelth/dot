import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


class Pip(package.HandlerMixin, package.InstallMixin, package.UpdateMixin, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'pip'
        self._install_cmd = 'pip3 install'
        self._list_cmd = 'pip3 list'
        self._update_cmds = ['pip3 freeze --local | grep -v \'^-e\' | cut -d = -f 1 | xargs -n1 pip3 install -U --user']
        super(Pip, self).__init__(context)
