#!/bin/bash

COMPOSEFILE="$1"
MANAGERFILE="$2"
MANAGER="$3"

usage(){
	echo "Usage: $0 PARAMs"
	echo " "
	echo "Deploy docker serice to swarm"
	echo " "
	echo "Params:"
	echo "  composefile" " Dokcer compose file"
	echo "  managerfile" " json file for manager ssh"
	echo "  manager" "     manager ssh info"
	exit 1

}


if [ $# != 3 ];
then
	usage
	exit 1
fi



echo "scp docker-compose file to manager"
scp -P ${PORT} -r ${DIR}/${COMPOSEFILE} ${ser}:~


flag=`echo $MANAGER|awk '{print match($0,":")}'`;

if [ $flag -gt 0 ];then
	PORT=${MANAGER#*:}
	ser=${MANAGER%:*}
	scp -P ${PORT} -r ${COMPOSEFILE} ${ser}:~
else
	scp -r ${COMPOSEFILE} ${MANAGER}:~
fi



echo "Deploy ss-kcp"
./ssh-rpc-agent --mf ${MANAGERFILE} --tf tasks/deploy.json


