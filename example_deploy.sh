#!/bin/bash -x
# saltycontainer deployment example
# Script to build the container, deploy it, add it to the salt server, and provision it.
# NOTE: This Only works if docker and salt master are on the same server and assumes you have copied the states/pillars into place!

cd docker
docker build . -t saltycontainer
CONTAINER=$(docker run -d saltycontainer)
# I have found that The hostname is the first 12 characters of the container id.
# Sleep to give the container a moment to register with the salt server, then accept the key, then sleep so the minion can log in fully.
sleep 10
salt-key -a ${CONTAINER::12} -y
sleep 15
salt -G 'roles:saltycontainer' state.sls saltycontainer --output=json --static | tee /tmp/state_output.json
exit $?
