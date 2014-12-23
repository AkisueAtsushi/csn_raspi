#!/bin/bash

BASE_DIR=/home/pi/csn_raspi
TARGET_DIR=${BASE_DIR}/data

LASTDATE=`date +"%Y-%m-%d %I:00"`
LASTDATE_TIME=`date -d "${LASTDATE}" +"%s"`
LASTDATE=`date -d "${LASTDATE}" +"%Y%m%d%I"`

DB_NAME=csn
TABLE=Event

DUMP_FILE=${TARGET_DIR}/data_${LASTDATE}.sql

# every hour
mysqldump -u root ${DB_NAME} ${TABLE} --where="t0active < ${LASTDATE_TIME}" > ${DUMP_FILE}
bzip2 ${DUMP_FILE}

# delete
mysql -u root ${DB_NAME} -e "DELETE FROM Event WHERE t0active < ${LASTDATE_TIME}"
