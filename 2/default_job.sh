#!/bin/bash

export PATH=$PATH:/bin:/usr/bin:/usr/local/bin:$(dirname $0)
PWD=`eval pwd`
BASEDIR="$(dirname $0)/../"
LOGDIR="${PWD}/log"
LOGFILE="${LOGDIR}/works.log"
time=$(date "+%Y/%m/%d %H:%M:%S")
time2=$(date "+%Y_%m_%d_%H_%M_%S")

logkey=${LOGDIR}/job/${time2}$(echo "${*}" | md5sum | cut -c 1-5).log
mkdir -p ${LOGDIR}/job

echo "$time $* ${logkey}" >> ${LOGFILE}
echo "Running ${*} ..." >> ${logkey}

(bash -c "${*}") | tee -a ${logkey} 2>&1