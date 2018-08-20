# sskcp-server-deployment

Deploy sskcp-server-x86 on multiple machines

### Preparation 

##### Buy 4 VPS (Linode or Vultr is recommended)

Choose ubuntu 18.04 images 

##### Install docker 18.06.0-ce on vps

##### Install tree on vps

##### Choose one of vps as manager and make it as manager of docker swarm

* On vps chosen to be manager
```
docker swarm init
```
* On other vps, change token and MANGER_IP below

```
docker swarm join --token TOKEN MANAGER_IP:2377 

```
### Deployment

* Git clone

```
git clone https://github.com/meninasx86/sskcp-server-deployment.git
```


* Install packages

```
./install_package.sh

```

* Fill in swarm manager login info 

If login manager with username and password, please fill in `machine/manager_USER.json`

An example of manager_USER.json

```
  [
    {
        "Domain": "173.46.5.23",
        "Port": "22",
        "Username": "root",
        "SudoPassword": "ghtyu4",
        "Mode": "USERPASS"
    }
  ]
~    
```
If login manager with ssh key, please modify `machine/manager_SSHKEY.json`

An example of manager_SSHKEY.json, please notice that `SudoPassword` is not key password 

```
[
   {
        "Label": "manager",
        "SudoPassword": "fgh5647s",
        "Mode": "SSHKEY"
    }
] 

```  


* Deploy configuration file to all nodes  in swarm

```
./config_deploy.sh PATH CONFIG VPS1 VPS2 VPS3 VPS4 
```
Such as:

```
./config_deploy.sh ~/meninasx86/sskcp-server-deployment/sskcp_conf manager root@174.35.6.2:22 root@174.35.3.22:22 root@174.35.7.21:22

```

* Deploy sskcp-server

```
./deploy.sh PATH COMPOSEFILE MANAGERFILE MANAGER
```
Such as:

```
./deploy.sh ~/meninasx86/sskcp-server-deployment/sskcp-server.yml machine/manager_SSHKEY.json manager
```

* Uninstall manager

```
./ssh-rpc-agent --tf tasks/uninstall_m.json --mf machine/manager_SSHKEY.json

```

* Uninstall worker

Create a `woker.json` file under machine, for example

```
[
   {
        "Label": "aworker",
        "SudoPassword": "wk123_",
        "Mode": "SSHKEY"
    },
    {
        "Label": "bworker",
        "SudoPassword": "wk123_",
        "Mode": "SSHKEY"
    },
    {
        "Label": "cworker",
        "SudoPassword": "wk123_",
        "Mode": "SSHKEY"
    }
]

```

```
./ssh-rpc-agent --tf tasks/uninstall_w.json --mf machine/worker.json

```



