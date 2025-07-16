# baudi-docker
Docker image for running the portal

# Setup
## prerequisites
* git
* ant
* docker

## quick setup with docker
1. create dir and enter:  
   `mkdir baudi && cd baudi`
2. clone repos:  
   `git clone git@github.com:Baumann-Digital/portal-app.git && git clone git@github.com:Baumann-Digital/baudi-data.git && git clone git@github.com:Baumann-Digital/baudi-docker.git`
3. build xars:  
   `ant portal-app/build.xml update-baudi-docker && ant portal-app/build.xml update-baudi-docker`
4. create docker image and container:  
   `baudi-docker/build-run-docker.sh`

## How to setup everything (with docker pipeline)
* clone repos in same directory
  * portal: https://github.com/Baumann-Digital/portal-app (`git clone git@github.com:Baumann-Digital/portal-app.git`)
  * data: https://github.com/Baumann-Digital/baudi-data (`git clone git@github.com:Baumann-Digital/baudi-data.git`)
  * docker: https://github.com/Baumann-Digital/baudi-docker (`git clone git@github.com:Baumann-Digital/baudi-docker.git`)
* run to build xar-packages for portal and data and copy them to `baudi-docker/autodeploy`
  * `ant portal-app/build.xml update-baudi-docker`
  * `ant baudi-data/build.xml update-baudi-docker `
* adjust variables (if necessary) in `baudi-docker/build-run-docker.sh`
  * `imageName`: name of the docker image
  * `port`: port for the eXist-db
  * `password`: password for the eXist-db
    * default `"${1}"`: set random password
* run `baudi-docker/build-run-docker.sh`; this will
  * check if docker container / image already running / existing and if yes stop / delete it
  * build docker-image
  * run docker-image
* the eXist-db needs a few seconds to start, then the portal is available here: `http://localhost:8080` (if you changed port in `baudi-docker/build-run-docker.sh` you need to change it here, too)

## notes
* for developers: you can change docker-flags in `baudi-docker/build-run-docker.sh`s last line
  * `--rm` (remove): automatically remove the docker-container after it stops
  * `-it` (interactive terminal): run docker-container with an interactive terminal
  * `-d` (detached mode): run container as daemon, necessary for production server.
  * `--restart=always`: (re)start docker-container always, except it's stopped manually. useful on production server. caution: cannot use `--rm` at the same time.
* the BauDi-Apps expect the eXist-db option `EXIST_CONTEXT_PATH=/`. if you use it without the docker-pipeline on a existing eXist-db, you might consider that.
* show logs of docker-container: `docker logs baudi-docker`