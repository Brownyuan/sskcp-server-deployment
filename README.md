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
./install_packages.sh

```

* Fill in swarm manager login info 

If login manager with username and password, please fill in manager_USER.json

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
If login manager with ssh key, please modify manager_SSHKEY.json

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
./config_deploy.sh
```

* Deploy sskcp-server

```
./deploy.sh 
```


