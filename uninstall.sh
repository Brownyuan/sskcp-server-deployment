#!/bin/bash

MANAGERFILE="$1"

usage(){
	echo "Usage: $0 PARAMS"
	echo " "
	echo "Params:"
	echo "  managerfile" " json file for manager ssh"
	exit 1

}


if [ $# != 1 ];
then
	usage
	exit 1
fi




echo "Remove ss-kcp"
./ssh-rpc-agent --mf ${MANAGERFILE} --tf tasks/uninstall.json


