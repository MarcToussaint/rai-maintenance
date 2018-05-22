docker run -it \
       --volume="$PWD/..:/root/local:ro" \
       --volume="$HOME/.ssh:/root/.ssh:ro" \
       rai-maintenance /bin/bash -C /root/local/docker/run-in-docker.sh
