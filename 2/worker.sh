#!/bin/bash
PWD=`eval pwd`
BASEDIR="${PWD}/$(dirname $0)"
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin:${BASEDIR}
SERVER_HOST="localhost"
LOCAL_NAME="job-server-01-"
declare THREADS=3
PID_DIR="${PWD}/pid"
LOG_DIR="${PWD}/log"
WORKER="${2}"

if [ "$WORKER" = "" ]; then
    WORKER="default_job"
fi

__start( ) {
    mkdir -p "${PID_DIR}"
    declare i=0
    while [[ $i -lt $THREADS ]]; do
        (( i++ ))
        PIDFILE="${PID_DIR}/gearman-worker-${WORKER}-${i}.pid"
        PROMPT="-i ${PIDFILE} -h ${SERVER_HOST} -nw -f ${LOCAL_NAME}${WORKER} xargs ${BASEDIR}/${WORKER}.sh"
        gearman ${PROMPT} &
    done
}
 
__stop( ) {
    declare i=0
    while [[ $i -lt $THREADS ]]; do
        (( i++ ))
        PIDFILE="${PID_DIR}/gearman-worker-${WORKER}-${i}.pid"
        if [ ! -r $PIDFILE ] ; then
            echo "Warning, no pid${i} file found - Is gearman running?"
            exit 1
        fi
        kill -TERM `cat $PIDFILE`
        rm -f $PIDFILE
    done
}
 
__show_usage( ) {
  echo "Usage: {start|stop|restart}"
  exit 1
}
 
testing1=$(echo "${SERVER_HOST}" | grep "ERROR")
if [ "${testing1}" != "" ]; then
    echo "${SERVER_HOST}"
    exit 1
fi
 
testing2=$(echo "${LOCAL_NAME}" | grep "ERROR")
if [ "${testing2}" != "" ]; then
    echo "${LOCAL_NAME}"
    exit 1
fi
 
case "$1" in
    start)
        echo "Starting Gearman Worker... ${WORKER}"
        __start
        ;;
    stop)
        echo "Stoping Gearman Worker... ${WORKER}"
        __stop
        ;;
    restart)
        $0 stop ${WORKER}
        $0 start ${WORKER}
        ;;
    *)
        __show_usage
        ;;
esac