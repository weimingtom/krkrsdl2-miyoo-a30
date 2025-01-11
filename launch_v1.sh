#!/bin/sh
#./krkrsdl2_a30: error while loading shared libraries: libSDL2-2.0.so.0: cannot open shared object file: No such file or directory
#only miyoo a30 need, but rg28xx not need

#echo $0 $*
#progdir=`dirname "$0"`
cd /mnt/SDCARD/App/krkrsdl2/

if pgrep krkrsdl2 > /dev/null; then
    killall -9 krkrsdl2
fi

#ulimit -c unlimited
#LD_LIBRARY_PATH=/usr/miyoo/lib $progdir/krkrsdl2_a30 > /mnt/SDCARD/krkrsdl2/a.txt 2>&1
#LD_LIBRARY_PATH=/usr/miyoo/lib /mnt/SDCARD/krkrsdl2/krkrsdl2_a30 > /mnt/SDCARD/krkrsdl2/a.txt 2>&1
/mnt/SDCARD/App/krkrsdl2/krkrsdl2
