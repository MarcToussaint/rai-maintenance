#/bin/sh

docker build \
       --tag rai-full18 \
       --network host \
       -f Dockerfile . #--no-cache
