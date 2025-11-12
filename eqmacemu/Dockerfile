FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends build-essential libtool cmake curl debconf-utils git libluabind-dev libsodium-dev liblua5.2-0 liblua5.2-dev libmariadb-dev libssl-dev minizip make mariadb-client locales nano open-vm-tools unzip uuid-dev iputils-ping wget libcurl4-openssl-dev gdb libyaml-cpp-dev ccache ninja-build pv mariadb-server libperl-dev libjson-perl libio-stringy-perl liblua5.1-dev libluabind-dev libboost-dev mariadb-server valgrind telnet ca-certificates

RUN git clone https://github.com/EQMacEmu/Server.git src

# Build Arg to circumvent client file checksums on server.
# This option will allow a quarm client to login, though its unknown if any other issues exist
ARG DISABLE_CHECKSUM
RUN if [ "$DISABLE_CHECKSUM" = "true" ]; then \ 
        # Insert "return true;" immediately after the function's opening brace
        sed -i '/bool Client::HandleChecksumPacket(const EQApplicationPacket \*app)/,/^{/!b;/^{/a\    return true;' src/world/client.cpp; \
    fi


RUN mkdir src/build && \
    cd src/build && \
    cmake -DEQEMU_BUILD_LOGIN=ON -DEQEMU_BUILD_TESTS=ON -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -G Ninja ..
RUN cd src/build && \
    cmake --build . --config Release --target all --

RUN git clone https://github.com/EQMacEmu/quests.git quests

RUN git clone https://github.com/EQMacEmu/Maps.git Maps

RUN mkdir data && \
    cd data && \
    mv /src/utils/sql/database_full/alkabor_latest.zip . && \
    unzip alkabor_latest.zip && \
    rm -f alkabor_latest.zip

COPY init.sh .
RUN ./init.sh

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]

