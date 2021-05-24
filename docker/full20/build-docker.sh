#/bin/sh

docker build \
       --tag rai-full20 \
       --network host \
       -f Dockerfile . #--no-cache
