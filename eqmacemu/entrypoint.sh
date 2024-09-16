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
./loginserver > /dev/stdout 2> /dev/stderr &
./world > /dev/stdout 2> /dev/stderr &
./eqlaunch 'dynzone1' > /dev/stdout 2> /dev/stderr &
./eqlaunch 'boats' > /dev/stdout 2> /dev/stderr &
./queryserv > /dev/stdout 2> /dev/stderr &
./ucs > /dev/stdout 2> /dev/stderr &

echo "Server is ready..."

exec tail -f /dev/null
