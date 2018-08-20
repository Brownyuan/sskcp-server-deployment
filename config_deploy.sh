#!/bin/bash

CONFIG="$1"
machine1=$2
machine2=$3
machine3=$4
machine4=$5



usage(){
	echo "Usage: $0 PARAMs"
	echo " "
	echo "Put configuration directory to all machines"
	echo " "
	echo "Params:"
	echo "  config" "Configuration dir"
	echo "  machine1" "  Username@Password:port or label"
	echo "  machine2" "  Username@Password:port or label"
	echo "  machine3" "  Username@Password:port or label"
	echo "  machine4" "  Username@Password:port or label"
	exit 1
}


if [ $# != 5 ];
then
	usage
	exit 1
fi

machine_list=("${machine1}" "${machine2}" "${machine3}" "${machine4}")

for machine in ${machine_list[@]}
do
	flag=`echo $machine|awk '{print match($0,":")}'`;
	echo $flag
	if [ $flag -gt 0 ];then
		PORT=${machine#*:}
		ser=${machine%:*}
		scp -P ${PORT} -r ${CONFIG} ${ser}:~
	    ssh -p ${PORT} -t ${ser} "sudo mkdir /app_data ;sudo mkdir /app_data/sskcp_conf; sudo cp -r ~/sskcp_conf /app_data; sudo tree /app_data ;"

	else
		scp -r ${CONFIG} ${machine}:~
	    ssh -t ${machine} "sudo mkdir /app_data ;sudo mkdir /app_data/sskcp_conf; sudo cp -r ~/sskcp_conf /app_data; sudo tree /app_data ;"
	fi
done

