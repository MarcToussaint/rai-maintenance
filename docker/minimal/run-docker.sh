#/bin/sh

thispath=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`" > /dev/null && pwd)

#see http://wiki.ros.org/docker/Tutorials/GUI
#https://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container

##WARNING! UNSAFE VERSION
# xhost +local:root
## later call:
# xhost -local:root

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 755 $XAUTH

docker run -it \
       --volume="$thispath/../..:/root/local" \
       --volume="$thispath/docker.bashrc:/root/.bash_aliases" \
       --volume="$HOME/.gitconfig:/root/.gitconfig:ro" \
       --volume="$HOME/.ssh:/root/.ssh:ro" \
       --env="DISPLAY" \
       --network host \
       -v $XSOCK:$XSOCK \
       -v $XAUTH:$XAUTH \
       -e XAUTHORITY=$XAUTH \
       rai-maintenance-minimal /bin/bash -C /root/local/docker/minimal/run-in-docker.sh
