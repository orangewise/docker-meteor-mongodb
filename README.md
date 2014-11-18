docker-meteor
=============

Run your meteor app in a docker container using boot2docker.

Your app connects to mongodb that also runs in a linked docker container. 

Based on [waitingkuo/docker-meteor](https://github.com/waitingkuo/docker-meteor).


## Setup

Download the latest boot2docker installer for mac [here](https://github.com/boot2docker/boot2docker/releases).
  
Setup port forwarding for port 80:

    $ boot2docker stop
    $ VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port80,tcp,,80,,80";
    $ boot2docker start


Clone this repo and add the location to your PATH.


## Build your meteor bundle 

    # bundle your app for linux
    $ meteor build . --architecture os.linux.x86_64

## deploy.yml

Create a deploy.yml file in the same folder as your meteor bundle. It should looks like this:

    db:
      name: mongodb
      container: robodo/mongodb:latest
  
    app:
      name: test
      bundle: microscope.tar.gz


## Example

    # deploy locally using boot2docker
    $ deploy

    # check if your containers are running
    $ docker ps
    CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS              PORTS                        NAMES
    08f4cc850485        test:latest             "/bin/sh -c 'node bu   23 minutes ago      Up 2 minutes        0.0.0.0:80->80/tcp           condescending_mccarthy   
    9b80b8966d2a        robodo/mongodb:latest   "/bin/sh -c usr/bin/   50 minutes ago      Up 3 minutes        127.0.0.1:27017->27017/tcp   mongodb                  


    # check app 
    $ curl `boot2docker ip` 

