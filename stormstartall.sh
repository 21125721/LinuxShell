#!/bin/bash
#nimbus nodes
nimbusServers='hadoop1'

#supervisor nodes
supervisorServers='hadoop1'

#logviewer nodes
logviewerServers='hadoop1'

#zookeeper nodes
zookeeperServers='hadoop1 hadoop2 hadoop3'

for zookeeper in $zookeeperServers
do
    COUNT=`ssh $zookeeper ps -ef |grep zookeeper |grep -v "grep" |wc -l`
    if [ $COUNT -eq 0 ];
       then
           echo $zookeeper ZooKeeper 没有运行...;
           exit;
    elif [ $COUNT -gt 0 ];
       then
           echo $zookeeper ZooKeeper 已经运行...;
           continue;
    fi
done

#start all nimbus
for nim in $nimbusServers
do
    ssh -T $nim <<EOF
        source /etc/profile
        cd \$STORM_HOME
        nohup bin/storm nimbus >/dev/null 2>&1 &
EOF
echo 从节点 $nim 启动nimbus...[ done ]
sleep 1
done

#start all ui
for u in $nimbusServers
do
    ssh -T $u <<EOF
        source /etc/profile
        cd \$STORM_HOME
        nohup bin/storm ui >/dev/null 2>&1 &
EOF
echo 从节点 $u 启动ui...[ done ]
sleep 1
done

#start all supervisor
for visor in $supervisorServers
do
    ssh -T $visor <<EOF
        source /etc/profile
        cd \$STORM_HOME
        nohup bin/storm supervisor >/dev/null 2>&1 &
EOF
echo 从节点 $visor 启动supervisor...[ done ]
sleep 1
done

#start all logviewer
for log in $supervisorServers
do
   ssh -T $log <<EOF
       cd \$STORM_HOME
       nohup bin/storm logviewer > /dev/null 2>&1 &
EOF
echo 从节点 $log 启动logviewer...[ done ]
sleep 1
done

















