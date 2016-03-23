#!/bin/bash

source functions.sh || (echo "functions.sh not found!"; exit)
source config.sh || (echo "config.sh not found!"; exit)

RUN_GDB=false
if [[ "$1" == "--debug" ]]; then
    RUN_GDB=true
    shift
fi

iostat -dmtx 1 > iostat.txt 2> /dev/null &
IOSTAT_PID=$!

mpstat 1 > mpstat.txt 2> /dev/null &
MPSTAT_PID=$!

KITS_OPTS=""

DBDIR=${MOUNTPOINT[db]}
if [ -n "$DBDIR" ]; then
    if [ "${USE_BTRFS[db]}" == "true" ]; then DBDIR=$DBDIR/new; fi
    KITS_OPTS+=" --sm_dbfile $DBDIR/db"
fi

LOGDIR=${MOUNTPOINT[log]}
if [ -n "$LOGDIR" ]; then
    if [ "${USE_BTRFS[log]}" == "true" ]; then LOGDIR=$LOGDIR/new; fi
    KITS_OPTS+=" --sm_logdir $LOGDIR/log"
fi

ARCHDIR=${MOUNTPOINT[archive]}
if [ -n "$ARCHDIR" ]; then
    if [ "${USE_BTRFS[archive]}" == "true" ]; then ARCHDIR=$ARCHDIR/new; fi
    KITS_OPTS+=" --sm_archdir $ARCHDIR/archive"
fi

CMD="zapps kits $KITS_OPTS $*"
EXIT_CODE=0

if $RUN_GDB; then
    gdb -ex run --args $CMD
else
    $CMD 1> out1.txt 2> out2.txt
    EXIT_CODE=$?
fi

kill $IOSTAT_PID > /dev/null 2>&1
kill $MPSTAT_PID > /dev/null 2>&1

exit $EXIT_CODE
