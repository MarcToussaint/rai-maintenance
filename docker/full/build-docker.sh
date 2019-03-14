#/bin/sh

docker build \
       --tag rai-maintenance-full \
       --network host \
       -f Dockerfile . #--no-cache
