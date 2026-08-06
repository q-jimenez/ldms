#! /bin/bash
if test $USER = root; then
    echo Cannot run as root.
    exit 1
fi
mkdir -p obj
mkdir -p install
Top=$(pwd)
cd obj
rm -rf *
source ~/ldms-venv/bin/activate || python3 -m venv ~/ldms-venv && source ~/ldms-venv/bin/activate && pip install Cython==0.29.36

export CFLAGS="-g -O0"

#export CFLAGS="-g -O0 -fno-pie"
#export LDFLAGS="-no-pie"

#export CFLAGS="-g -O0 -std=gnu11"
export PKG_CONFIG_PATH=$HOME/variorum/install/share/pkgconfig:$PKG_CONFIG_PATH
../configure --prefix=$Top/install --enable-papi --with-libpapi-prefix=$HOME/papi --with-libpfm-prefix=$HOME/papi --enable-variorum --with-libvariorum-prefix=$HOME/variorum/install
make -j && chmod +x ../ldms/man/make_exits_man.sh && make install
source $TOP/ldmsenv.sh
#../install/bin/ldms-static-test.sh meminfo #meminfo test
#../install/bin/ldms-static-test.sh perfevent2 #perfevent2 test