#Stop all docker containers
docker stop $(docker ps -a -q)

#Remove all Containers
docker rm $(docker ps -a -q)

#Remove all Images
docker rmi $(docker images -q)
