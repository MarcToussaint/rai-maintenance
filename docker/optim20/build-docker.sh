#/bin/sh

docker build \
       --tag rai-optim20 \
       --network host \
       -f Dockerfile . #--no-cache
