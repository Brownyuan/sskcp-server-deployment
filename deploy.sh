#!/bin/bash

DIR="$1"
COMPOSEFILE="$2"
MANAGERFILE="$3"
MANAGER="$4"
PORT=${MANAGER#*:}
ser=${MANAGER%:*}

usage(){
	echo "Usage: $0 PARAMs"
	echo " "
	echo "Params:"
	echo "  path" "        Path to docker compose file"
	echo "  composefile" " Dokcer compose file"
	echo "  managerfile" " json file for manager ssh"
	echo "  manager" "     manager ssh info"
	exit 1

}


if [ $# != 4 ];
then
	usage
	exit 1
fi



echo "scp docker-compose file to manager"
scp -P ${PORT} -r ${DIR}/${COMPOSEFILE} ${ser}:~

echo "Deploy ss-kcp"
./ssh-rpc-agent --mf ${MANAGERFILE} --tf deploy.json


