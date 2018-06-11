#/bin/sh

thispath=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`" > /dev/null && pwd)

xhost +local:root

docker run -it \
       --volume="$thispath/../..:/root/local" \
       --volume="$thispath/docker.bashrc:/root/bashrc" \
       --volume="$HOME/.gitconfig:/root/.gitconfig:ro" \
       --volume="$HOME/.ssh:/root/.ssh:ro" \
       --env="DISPLAY" \
       --publish 11311:11311 \
       --network host \
       rai-maintenance-full /bin/bash

xhost -local:root
