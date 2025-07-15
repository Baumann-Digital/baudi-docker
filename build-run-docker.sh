#!/bin/bash
# build or update the baudi docker image and run it in a container.
# before you have to add the packages to the autodeploy dir!

#set variables
imageName=baudi-docker
containerRunning=$(docker ps -q -f name=$imageName)
password="${1:-password}"
port=8080

# check if the container is already running
# if yes, it will be stopped and a new one is started
if [ $containerRunning ];
then
  echo 'container '$imageName' is already running, stopping it ...'
  docker stop $containerRunning
  #sleep 5s
fi

# check if the image already exists
# if yes, it will be removed
if [[ -n "$(docker images -q $imageName)" ]]; then
  echo 'image '$imageName' already exists, removing it ...'
  docker image rm $imageName
  #sleep 5s
fi

# (re)build the docker image
docker build -f Dockerfile.local -t $imageName .

# run a container
docker run --rm -it -p $port:8080 --name $imageName -e EXIST_DEFAULT_APP_PATH=xmldb:exist:///db/apps/baudiApp -e EXIST_PASSWORD=$password -e EXIST_CONTEXT_PATH=/ $imageName
