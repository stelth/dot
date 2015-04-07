#!/bin/bash
# Script to open Vimprobable instances in tabbed
exec vimprobable2 -e $(</tmp/tabbed.xid) "$1" > /dev/null 2>&1
