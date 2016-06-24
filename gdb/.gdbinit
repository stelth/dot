set disassembly-flavor intel
set disassemble-next-line on

python
import sys
import os

sys.path.insert(0, os.path.expanduser('~/bin/gdb_printers/python'))

from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)

sys.path.insert(0, os.path.expanduser('~/bin/gdb_printers/python/qt'))
from qt import register_qt_printers
register_qt_printers (None)

end
