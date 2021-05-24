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
RUN apt-get --yes install \
    python3-dev python3 python3-numpy python3-pip python3-distutils


##########################################################
# Install python packages:

ENV PATH="${PATH}:/root/.local/bin"

RUN pip3 install --user pybind11 jupyter nbconvert matplotlib


##########################################################
# follow README

ENV REPO="rai"

# clone
RUN \
cd $HOME && \
git clone --recursive https://github.com/MarcToussaint/$REPO && \
git clone --recursive https://github.com/MarcToussaint/rai-robotModels

# install ubuntu
RUN make -C $HOME/$REPO -j1 APTGETYES="--yes" installUbuntuAll

# compile
RUN \
cd $HOME/$REPO && \
git checkout marc && \
make -j $(command nproc) src tests

# install/cp package
#RUN cp $HOME/$REPO/build/lib


##########################################################

WORKDIR /root

RUN printf "\necho '*** Welcome to the full20 docker! ***'" >> $HOME/.bashrc

