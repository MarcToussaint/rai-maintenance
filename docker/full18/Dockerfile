FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME="/root"
ENV TERM="xterm"

##########################################################
# basic ubuntu packages

RUN apt-get --yes update
RUN apt-get --yes install \
    apt-utils git sudo g++ make gnupg gdb cmake \
    x11-apps mesa-utils \
    emacs terminator lsb-release gnuplot


##########################################################
# checkout rai and install necessary ubuntu packages

RUN \
mkdir -p $HOME && \
cd $HOME && \
git clone https://github.com/MarcToussaint/rai.git && \
git clone https://github.com/MarcToussaint/rai-robotModels.git && \
cd rai && \
git checkout marc && \
printf "APTGETYES=--yes\nOPTIM=fast\nOPENCV=0\nPCL=0\nROS=0\n" > config.mk && \
make -j1 installUbuntuAll


##########################################################
# pre-install debian packages

# RUN apt-get --yes install \
# g++ make gnupg gdb cmake gnuplot evince libjsoncpp-dev libx11-dev \
# liblapack-dev libf2c2-dev libeigen3-dev libann-dev libqhull-dev \
# libx11-dev libglfw3-dev libglew-dev freeglut3-dev graphviz graphviz-dev \
# libfcl-dev libassimp-dev libbullet-dev \
# libnlopt-dev gfortran coinor-libipopt-dev libceres-dev \
# python3 python3-dev python3-numpy python3-pip python3-distutils


##########################################################
# Install python packages:

RUN \
pip3 install --user pybind11 jupyter matplotlib

ENV PATH="${PATH}:/root/.local/bin"


##########################################################
# Install Physx 3.4 (literally from https://github.com/MarcToussaint/rai-maintenance/blob/master/help/localSourceInstalls.md#physx)

RUN \
mkdir -p $HOME/git && \
cd $HOME/git && \
git clone https://github.com/NVIDIAGameWorks/PhysX.git && \
cd PhysX && \
git checkout 3.4 && \
cd PhysX_3.4/Source/compiler/linux64 && \
make -j $(command nproc) release && \
mkdir -p $HOME/opt/physx3.4/lib && \
mkdir -p $HOME/opt/physx3.4/include/physx && \
cd $HOME/git/PhysX && \
cp PhysX_3.4/Bin/linux64/* $HOME/opt/physx3.4/lib && \
cp PhysX_3.4/Lib/linux64/* $HOME/opt/physx3.4/lib && \
cp PxShared/bin/linux64/* $HOME/opt/physx3.4/lib && \
cp -R PhysX_3.4/Include/* $HOME/opt/physx3.4/include/physx && \
cp -R PxShared/include/* $HOME/opt/physx3.4/include/physx && \
rm -Rf $HOME/git/PhysX

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/root/opt/physx3.4/lib"


##########################################################
# compile rai

RUN \
cd $HOME/rai && \
make -j $(command nproc) src tests


##########################################################

WORKDIR /root
RUN printf "\ncat $HOME/local/docker/full18/message" >> $HOME/.bashrc
