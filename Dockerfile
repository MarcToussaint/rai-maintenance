FROM ubuntu:16.04

RUN apt-get --yes update
RUN apt-get --yes install git sudo make nano g++ x11-apps

# this is only to speed up
# the make initUbuntuPackage would do the same in the test shell...
RUN apt-get --yes install g++ libx11-dev liblapack-dev libf2c2-dev gnuplot libjsoncpp-dev libann-dev libglew-dev libqhull-dev freeglut3-dev graphviz-dev


ADD run-in-docker.sh /opt/run-in-docker.sh

ENV DISPLAY :0
