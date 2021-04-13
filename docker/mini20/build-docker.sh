#/bin/sh

docker build \
       --tag rai-mini20 \
       --network host \
       -f Dockerfile . #--no-cache
