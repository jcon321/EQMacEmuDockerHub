#!/bin/bash

# ./docker-publish.sh q
#    To publish checksum disabled variant
# ./docker-publish.sh
#    To publish regular image

docker login

if [ "$1" == "q" ]; then
  docker push eqmacemu/eqmacemu:q-latest
else
  docker push eqmacemu/eqmacemu:latest
fi

# TODO = Should I tag more than just latest?
#   - Since I always push latest, then people who have once pulled (and have a database) may re-pull and get an image that is not compatable with their database
#       - However, docker wont overwrite the named volume if it exists and has data
#       - Additionally, docker wont fetch a "latest" if the eqmacemu:latest exists locally (even if remote is newer), unless forced
#       - (So there are safeguards against this)
#   - But if I push a tag then people could fetch the image they once used that is compatable with their database.
#       - However, they'd have to specify the tag upon their original pull and that adds friction to the goal of the simple docker run command
