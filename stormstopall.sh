#!/bin/bash
#nimbus节点
nimbusServers='hadoop1'

#supervisor节点
supervisorServers='hadoop1'

#停止所有的nimbus和ui
for nim in $nimbusServers
do
    echo 从节点 $nim 停止nimbus和ui...[ done ]
    ssh $nim "kill -9 `ssh $nim ps -ef | grep nimbus | awk '{print $2}'| head -n 1`" >/dev/null 2>&1
    ssh $nim "kill -9 `ssh $nim ps -ef | grep ui | awk '{print $2}'| head -n 1`" >/dev/null 2>&1
done

#停止所有的supervisor
for visor in $supervisorServers
do
    echo 从节点 $visor 停止supervisor...[ done ]
    ssh $visor "kill -9 `ssh $visor ps -ef | grep supervisor | awk '{print $2}'| head -n 1`" >/dev/null 2>&1
done

#停止所有的logviewer
for log in $supervisorServers
do
    echo 从节点 $log 停止logviewer...[ done ]
    ssh $log "kill -9 `ssh $log ps -ef | grep logviewer | awk '{print $2}' | head -n 1`" >/dev/null 2>&1
done
