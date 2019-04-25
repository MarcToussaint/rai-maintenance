#/bin/sh

docker build \
       --tag rai-maintenance-mini18 \
       --network host \
       -f Dockerfile . #--no-cache
