#/bin/sh

docker build \
       --tag rai-maintenance-mini16 \
       --network host \
       -f Dockerfile . #--no-cache
