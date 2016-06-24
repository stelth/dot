set disassembly-flavor intel
set disassemble-next-line on

python
import sys
import os

sys.path.insert(0, os.path.expanduser('~/bin/gdb_printers/python'))

from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)

import qt5printers
qt5printers.register_printers(gdb.current_objfile())

end
