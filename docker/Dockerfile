FROM ubuntu:16.04

RUN apt-get --yes update
RUN apt-get --yes install git sudo make nano g++ x11-apps

# this is only to speed up
# the make initUbuntuPackage would do the same in the test shell...
RUN apt-get --yes install \
    g++ liblapack-dev libf2c2-dev \
    gnuplot libjsoncpp-dev libann-dev libqhull-dev
#    libx11-dev libglew-dev freeglut3-dev graphviz-dev
