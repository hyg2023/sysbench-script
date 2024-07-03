#!/bin/bash


DIR=/root/sysbench_test_result
HOST=xxx.xxx.xxx.xxx
USER=xxxx
PWD=xxxx
PORT=3306
DB=test
TB=120
TB_SIZE=20000000
T_TIME=1200

if [! -d $DIR];then
	mkdir $DIR
fi


for THREADS in 10 20 30 40 50 60 70 80 90 100
do
	echo "$THREADS test start" >> ${DIR}/sysbench_time.log;
	date >> ${DIR}/sysbench_time.log;
	sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-host=$HOST --mysql-user=$USER --mysql-password=$PWD --mysql-port=$PORT --mysql-db=$DB --tables=$TB --table-size=$TB_SIZE --threads=$THREADS --time=$T_TIME run > ${DIR}/${HOST}_ro_$THREADS;
	sysbench /usr/share/sysbench/oltp_write_only.lua --mysql-host=$HOST --mysql-user=$USER --mysql-password=$PWD --mysql-port=$PORT --mysql-db=$DB --tables=$TB --table-size=$TB_SIZE --threads=$THREADS --time=$T_TIME run > ${DIR}/${HOST}_wo_$THREADS;
	sysbench /usr/share/sysbench/oltp_read_write.lua --mysql-host=$HOST --mysql-user=$USER --mysql-password=$PWD --mysql-port=$PORT --mysql-db=$DB --tables=$TB --table-size=$TB_SIZE --threads=$THREADS --time=$T_TIME run > ${DIR}/${HOST}_rw_$THREADS;
done


