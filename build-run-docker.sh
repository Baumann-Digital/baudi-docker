#!/bin/bash
# build or update the baudi docker image and run it in a container.
# before you have to add the packages to the autodeploy dir!

#set variables
imageName=baudi-docker
containerRunning=$(docker ps -q -f name=$imageName)
password="${1:-password}"

#check if the container is already running
#if yes, it will be stopped and a new one is started
if [ $container ];
then
  docker stop $containerRunning
  #sleep 5s
fi

if [[ -n "$(docker images -q $imageName)" ]]; then
  docker image rm $imageName
  #sleep 5s
fi

# (re)build the docker image
docker build -f Dockerfile.local -t $imageName .

# run a container
docker run --rm -it -p 8080:8080 --name $imageName -e EXIST_DEFAULT_APP_PATH=xmldb:exist:///db/apps/baudiApp -e EXIST_PASSWORD=$password -e EXIST_CONTEXT_PATH=/ $imageName
