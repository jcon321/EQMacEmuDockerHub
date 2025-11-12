#!/bin/bash

# ./docker-build.sh q
#    To build checksum disabled variant
# ./docker-build.sh
#    To build regular image

if [ "$1" == "q" ]; then
  docker build --progress=plain --build-arg DISABLE_CHECKSUM=true -t eqmacemu/eqmacemu:q-latest ../
else
  docker build --progress=plain -t eqmacemu/eqmacemu:latest ../
fi
