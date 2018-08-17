#!/bin/bash

DIR="$1"
CONFIG="$2"
VPS1=$3
VPS2=$4
VPS3=$5
VPS4=$6



usage(){
	echo "$0 PARAMs"
	echo " "
	echo "Params:"
	echo "  path" "  Path to config dir"
	echo "  config" "Config dir"
	echo "  vps1" "  Username@Password:port"
	echo "  vps2" "  Username@Password:port"
	echo "  vps3" "  Username@Password:port"
	echo "  vps4" "  Username@Password:port"
	exit 1
}


if [ $# != 6 ];
then
	usage
	exit 1
fi

vps_list=("${VPS1}" "${VPS2}" "${VPS3}" "${VPS4}")

for vps in ${vps_list[@]}
do
	#echo ${vps}
	PORT=${vps#*:}
	#echo ${vps}
	ser=${vps%:*}

	#echo $vps
	#echo $PORT
	scp -P ${PORT} -r ${DIR}/${CONFIG} ${ser}:~
	#echo ${ser}
	#echo $PORT
	ssh -p ${PORT} -t ${ser} "sudo mkdir /app_data ;sudo mkdir /app_data/sskcp_conf; sudo cp -r ~/sskcp_conf /app_data/sskcp_conf; sudo tree /app_data ; sudo tree ~;"
done

