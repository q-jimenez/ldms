#! /bin/bash
mkdir obj
mkdir install
Top=$(pwd)
cd obj
rm -rf *
source ~/ldms-venv/bin/activate

export CFLAGS="-g -O0"

#export CFLAGS="-g -O0 -fno-pie"
#export LDFLAGS="-no-pie"

#export CFLAGS="-g -O0 -std=gnu11"

../configure --prefix=$Top/install
make -j && chmod +x ../ldms/man/make_exits_man.sh && make install
#../install/bin/ldms-static-test.sh meminfo #meminfo test
../install/bin/ldms-static-test.sh perfevent2 #perfevent2 test