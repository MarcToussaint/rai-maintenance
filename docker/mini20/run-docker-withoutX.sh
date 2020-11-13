#/bin/sh

thispath=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`" > /dev/null && pwd)

docker run -it \
       --volume="$thispath/../..:/root/local" \
       --volume="$HOME/:/root/home" \
       --volume="$thispath/docker.bashrc:/root/bashrc" \
       --volume="$HOME/.gitconfig:/root/.gitconfig:ro" \
       --volume="$HOME/.ssh:/root/.ssh:ro" \
       rai-maintenance-mini18 /bin/bash -C $1
