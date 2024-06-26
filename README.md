Home of https://hub.docker.com/r/eqmacemu/eqmacemu

This docker image represents a fully configured EQMac Emu Server (https://github.com/EQMacEmu/Server)

docker volume create eqmacemu-data
docker run -d -v eqmacemu-data:/var/lib/mysql -p 6000:6000/udp -p 5998:5998 -p 9000:9000/udp -p 9000:9000 -p 7778:7778/udp -p 7375-7400:7375-7400/udp -p 7375-7400:7375-7400 -p 7000-7374:7000-7374/udp -p 7000-7374:7000-7374 -p 3306:3306 eqmacemu/eqmacemu:latest
