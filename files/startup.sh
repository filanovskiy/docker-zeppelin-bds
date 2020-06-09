#!/bin/bash
mkdir -p /opt/cloudera/parcels/CDH/lib/spark/R/lib/SparkR
ln -s /usr/lib64/R/library/SparkR /opt/cloudera/parcels/CDH/lib/spark/R/lib/SparkR
ln -s /etc/alternatives/hdfs /bin/hdfs
ln -s /etc/alternatives/hadoop /bin/hadoop
/usr/sbin/rstudio-server start
shiny-server &
nohup $ZEPPELIN_HOME/bin/zeppelin.sh & > zeppelin-deamon.out &
sleep 2;
./notebook/OracleDemo/SparkSQL.sh
while [ 1 ]; do foo; sleep 2; done