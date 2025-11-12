#!/bin/bash

# Used just to test newly built images, lacks the -v flag which real run command would use

# ./docker-run.sh q
#    To run checksum disabled variant
# ./docker-run.sh
#    To run regular image

if [ "$1" == "q" ]; then
  docker run --name q-my-eqmacemu \
    -p 6000:6000/udp \
    -p 5998:5998 \
    -p 9000:9000/udp \
    -p 9000:9000 \
    -p 7778:7778/udp \
    -p 7375-7400:7375-7400/udp \
    -p 7375-7400:7375-7400 \
    -p 7000-7374:7000-7374/udp \
    -p 7000-7374:7000-7374 \
    -p 3306:3306 \
    eqmacemu/eqmacemu:q-latest
else
  docker run --name my-eqmacemu \
    -p 6000:6000/udp \
    -p 5998:5998 \
    -p 9000:9000/udp \
    -p 9000:9000 \
    -p 7778:7778/udp \
    -p 7375-7400:7375-7400/udp \
    -p 7375-7400:7375-7400 \
    -p 7000-7374:7000-7374/udp \
    -p 7000-7374:7000-7374 \
    -p 3306:3306 \
    eqmacemu/eqmacemu:latest
fi
