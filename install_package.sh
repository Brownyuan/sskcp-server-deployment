#!/bin/bash

package="ssh-rpc-agent"
version="0.0.4"

download() {
	wget https://github.com/FuQiFeiPian/ssh-rpc-agent/releases/download/${version}/${package}-${version}.zip
}

unzip_packages() {
	unzip ${package}-${version}.zip
}

link(){
	arch=`uname -m`
	case $arch in
		x86_64) ln -s ${package}-${version}/ssh-rpc-agent-amd64 ./ssh-rpc-agent;;
		*) echo $arch
	esac
	
}

download
unzip_packages
link
