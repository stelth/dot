import dotbot

import imp
import pathlib
path = "%s/package.py" % pathlib.Path(__file__).parent.absolute()

package = imp.load_source('package', path)

@package.installable
@package.updateable
class Apt(package.PackageHandler, dotbot.Plugin):
    def __init__(self, context):
        self._directive = 'apt'
        self._install_cmds = ['apt-get install']
        self._list_cmd = 'apt list'
        self._update_cmds = [
                    'apt-get update -y --allow-unauthenticated',
                    'apt-get upgrade -y --allow-unauthenticated',
                    'apt-get dist-upgrade -y -f --allow-unauthenticated',
                    'apt autoremove -y -f'
                ]
        super(Apt, self).__init__(context)
