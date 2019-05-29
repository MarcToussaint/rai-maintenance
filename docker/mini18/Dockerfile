FROM ubuntu:18.04

RUN apt-get --yes update
RUN apt-get --yes install \
    git sudo g++ make gnupg \
    x11-apps mesa-utils \
    nano emacs terminator lsb-release gnuplot

# this is only to speed up
# the make initUbuntuPackage would do the same in the test shell...

#RUN apt-get --yes install \
#    liblapack-dev libf2c2-dev \
#    libx11-dev libglew-dev freeglut3-dev graphviz-dev

WORKDIR /root
