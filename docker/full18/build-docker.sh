#/bin/sh

docker build \
       --tag rai-maintenance-full18 \
       --network host \
       -f Dockerfile . #--no-cache
