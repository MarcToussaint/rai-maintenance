#/bin/sh

thispath=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`" > /dev/null && pwd)

xhost +local:root

docker run -it \
       --volume="$thispath/../..:/root/local" \
       --volume="$thispath/docker.bashrc:/root/.bash_aliases" \
       --volume="$HOME/.gitconfig:/root/.gitconfig:ro" \
       --volume="$HOME/.ssh:/root/.ssh:ro" \
       --env="DISPLAY" \
       --network host \
       --publish 11311:11311 \
       --device /dev/input \
       rai-maintenance-full18 /bin/bash -C $1

xhost -local:root
