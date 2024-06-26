#!/bin/bash
echo "Starting EQMacEmu..."

# Start database
service mariadb start
sleep 3

cd /src/build/bin

# Start shared_memory
./shared_memory &> shared_memory.log
sleep 3

# Start background processes
./loginserver &> login.log &
./world &> world.log &
./eqlaunch 'dynzone1' &> eqlaunch.log &
./eqlaunch 'boats' &> eqlaunch-boats.log &
./queryserv &> queryserv.log &
./ucs &> ucs.log &

echo "Server is ready..."

exec tail -f /dev/null
