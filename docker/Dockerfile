# saltycontainer - A Docker Image that runs a salt minion for provisioning.
# Parts from https://github.com/mingfang/docker-salt/blob/master/Dockerfile

# We want 14.04 as our base image
FROM ubuntu:14.04

# Might as well put my name on it :)
MAINTAINER Jesse Rhoads <jesserhoads@gmail.com>

# Set non-interactive mode by default, because apparently apt doesn't play nice inside a container without a tty otherwise.
ENV DEBIAN_FRONTEND noninteractive

# Necessary to Refresh the repository cache before we start installing stuff.
RUN apt-get update

# Install any base image dependencies that you will need to further install software
RUN apt-get install -y wget curl dnsutils git python-dev python-pip

# Add the public Salt apt Repo (could also be done by mirroring on a private repo) and key. Updated to use the saltstack offical/latest repo.
RUN wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
RUN echo 'deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main' > /etc/apt/sources.list.d/saltstack.list
RUN apt-get update

# Install Salt Minion
RUN apt-get install -y salt-minion 

# Place the local Configuration for the salt minion.  This file is where you would specify the hostname of the salt master and any minion tunings.
ADD minion /etc/salt/minion

# For now, just run out of the root directory.
ENV HOME /root

# Chroot things to /root 
WORKDIR /root

# Open port 9000 for the web service we will run inside the container
EXPOSE 9000

# Seed the script that keeps the container alive.
ADD idle.sh /root/idle.sh

# Run the main script using bash
CMD ["/bin/bash","/root/idle.sh"]

