docker-meteor
=============

Run your meteor app in a docker container using boot2docker.

Based on [waitingkuo/docker-meteor](https://github.com/waitingkuo/docker-meteor)


## Setup

Download the latest boot2docker installer for mac [here]()
  
Setup port forwarding for port 80



## Example

  # download 



    # init test environment
    vagrant up
    cat ~/.ssh/id_dsa.pub | ssh vagrant@192.168.66.66 'cat >> .ssh/authorized_keys'

    # make the bundle of meteor app
    cd meteor
    meteor bundle bundle.tar.gz
    cd ..

    # deploy
    ./deploy vagrant@192.168.66.66 app1 bundle.tar.gz

    # check whether it runs successfully
    curl 192.168.66.66

    # stop it
    ./stop vagrant@192.168.66.66 app1
