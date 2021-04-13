FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME="/root"
ENV TERM="xterm"

##########################################################
# basic ubuntu packages

RUN apt-get --yes update
RUN apt-get --yes install \
    apt-utils git sudo build-essential gnupg gdb cmake \
    x11-apps mesa-utils \
    emacs terminator lsb-release gnuplot

# this is only to speed up
# the make installUbuntuAll would do the same in the test shell...

RUN apt-get --yes install \
libx11-dev libglfw3-dev libglew-dev freeglut3-dev \
libassimp-dev libglew-dev freeglut3-dev libqhull-dev \
libann-dev liblapack-dev libf2c2-dev \
g++ make gnupg gdb cmake gnuplot libjsoncpp-dev libx11-dev liblapack-dev libf2c2-dev

##########################################################

WORKDIR /root

RUN printf "\necho '*** Welcome to the mini20 docker! ***'" >> $HOME/.bashrc

