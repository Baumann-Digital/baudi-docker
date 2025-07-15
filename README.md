# baudi-docker
Docker image for running the portal



## notes
- you can change some properties in `build-run-docker.sh`:
  - `imageName`: name of the docker image
  - `port`: port for the eXist-db
  - `password`: password for the eXist-db
    - default `"${1}"`: set random password
- for developer: flag `docker run`