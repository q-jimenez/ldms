#!/bin/bash
if ! test $USER = root; then
    echo Not running as root, please change user.
else
	sysctl -w kernel.perf_event_paranoid=0
	prefix=$HOME/ldms/install
	exec_prefix=${prefix}
	libdir=${exec_prefix}/lib
	if ! test -f $libdir/ovis-lib-configvars.sh; then
		echo "$libdir/ovis-lib-configvars.sh not found"
		exit 1
	fi
	if ! test -f $libdir/ovis-ldms-configvars.sh; then
		echo "$libdir/ovis-ldms-configvars.sh not found"
		exit 1
	fi
	. $libdir/ovis-lib-configvars.sh
	. $libdir/ovis-ldms-configvars.sh
	if test -z "$ZAP_LIBPATH"; then
		ZAP_LIBPATH=$ovis_ldms_plugins
	fi
	export ZAP_LIBPATH
	if test -z "$LDMSD_PLUGIN_LIBPATH"; then
		LDMSD_PLUGIN_LIBPATH=$ovis_ldms_plugins
	fi
	export LDMSD_PLUGIN_LIBPATH
	export LD_LIBRARY_PATH=${ovis_ldms_plugins_rpath}:${BUILDDIR}/lib:${exec_prefix}/lib:$ovis_ldms_plugins:@libeventpath@:$LD_LIBRARY_PATH
	bname=`basename $0`
	USERDIR=$HOME
	BUILDDIR=${USERDIR}/ldms/install
	export PATH=${BUILDDIR}/bin:$PATH
	export PATH=${BUILDDIR}/sbin:$PATH
	export PYTHONPATH=${PYTHON_PREFIX}/lib/python3.12/site-packages:$PYTHONPATH
	export PATH=${USERDIR}/papi/bin:$PATH
	export LD_LIBRARY_PATH=${USERDIR}/papi/lib:$LD_LIBRARY_PATH
	export MINI_FE_PATH=${USERDIR}/miniFE/ref/basic
fi
