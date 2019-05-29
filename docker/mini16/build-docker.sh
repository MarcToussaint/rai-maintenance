#/bin/sh

docker build \
       --tag rai-maintenance-minimal \
       --network host \
       -f Dockerfile . #--no-cache
