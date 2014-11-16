#!/bin/bash


# check number of arguments (default to 0), store the values
[ ${BASH_ARGC-0} -ne 2 ] && { echo "[usage] ./deploy.sh APP_NAME BUNDLE_FILE"; exit 1; }
APP_NAME=${BASH_ARGV[1]}
BUNDLE_FILE=${BASH_ARGV[0]}


# check if boo2docker is running
IP=`boot2docker ip`
[ -z "$IP" ] && { echo "boot2docker is not running, start it with: boot2docker start"; exit 1; }
HOST=`echo docker@${IP}`


# Setup boot2docker environment
$(boot2docker shellinit)
cat ~/.ssh/id_dsa.pub | ssh $HOST 'cat >> .ssh/authorized_keys'


# create Dockerfile template 
DOCKERFILE="
FROM node
MAINTAINER @robodo

# install meteor
RUN curl https://install.meteor.com | /bin/sh

ADD . ./meteorsrc
WORKDIR /meteorsrc

# extract archive
RUN tar -zxf bundle.tar.gz
RUN cd bundle/programs/server && npm install

# set meteor environment
#ENV MONGO_URL='mongodb://user:password@host:port/databasename'
ENV ROOT_URL http://${IP}
ENV PORT 80
#ENV MAIL_URL='smtp://user:password@mailhost:port/'

# run the app
CMD node bundle/main.js
"

echo copy ${BUNDLE_FILE} to boot2docker ${HOST}
scp ${BUNDLE_FILE} ${HOST}:~/bundle.tar.gz
echo "${DOCKERFILE}" | ssh ${HOST} "cat - > Dockerfile"

echo build docker image with name ${APP_NAME} using Dockerfile
ssh ${HOST} sudo docker build -t ${APP_NAME} .

echo run docker image with name ${APP_NAME}
ssh ${HOST} sudo docker run -d -p 80:80 ${APP_NAME}