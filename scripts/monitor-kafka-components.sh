#!/bin/bash

IFS=$'\n's
for monitored_process in `cat ./kafka-components.properties | grep -v "^#"`
do
    monitored_process_footprint=`echo $monitored_process | cut -d"|" -f1`
    echo "Checking - ${monitored_process_footprint}"

    running_kafka_component_found=false
    
    for running_kafka_component in `jcmd -l | grep -v "jdk.jcmd/sun.tools.jcmd.JCmd" | cut -d" " -f2-`
    do
        if [ "${running_kafka_component}" = "${monitored_process_footprint}" ]
        then
            running_kafka_component_found=true
        fi 
    done
    echo "running_kafka_component_found=${running_kafka_component_found}"
    
done
