import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)

@package.installable
@package.updateable
class Brew(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'brew'
        self._install_cmds = ['brew install [flags] [package]']
        self._list_cmd = 'brew ls [flags] [package]'
        self._update_cmds = [
            'brew update',
            'brew upgrade',
            'brew cleanup',
            'brew cleanup -s',
            'brew missing',
            'brew bundle dump',
            'brew bundle --force cleanup',
            'rm Brewfile'
        ]
        super(Brew, self).__init__(context)
