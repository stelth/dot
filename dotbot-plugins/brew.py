import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)


class Brew(package.HandlerMixin, package.InstallMixin, package.UpdateMixin, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'brew'
        self._install_cmd = 'brew install'
        self._list_cmd = 'brew ls'
        self._update_cmds = [
            'brew update',
            'brew upgrade',
            'brew cleanup',
            'brew cleanup -s',
            'brew missing'
        ]
        super(Brew, self).__init__(context)
