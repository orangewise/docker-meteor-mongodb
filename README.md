docker-meteor
=============

Run your meteor app in a docker container using boot2docker.

Based on [waitingkuo/docker-meteor](https://github.com/waitingkuo/docker-meteor).


## Setup

Download the latest boot2docker installer for mac [here](https://github.com/boot2docker/boot2docker/releases).
  
Setup port forwarding for port 80:

    $ boot2docker stop
    $ VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port80,tcp,,80,,80";
    $ boot2docker start


Clone this repo and add the location to your PATH.


## Example


    # bundle your app
    $ meteor build . --architecture os.linux.x86_64

    # deploy locally using boot2docker
    $ deploy test bundle.tar.gz

    # check if your container is running
    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                NAMES
    3b0f0392ee0d        test:latest         "/bin/sh -c 'node bu   5 hours ago         Up 15 seconds       0.0.0.0:80->80/tcp   compassionate_ritchie   


    # check app 
    $ curl `boot2docker ip` 

