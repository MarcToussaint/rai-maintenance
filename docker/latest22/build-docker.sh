#/bin/sh

docker build \
       --tag rai-ubuntu \
       --network host \
       -f Dockerfile . #--no-cache
