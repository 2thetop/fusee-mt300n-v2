# fusee-nano builder image
FROM ubuntu:16.04 as build

LABEL maintainer="shawly <shawlyde@gmail.com>"

RUN apt-get update && \
    apt-get install build-essential subversion mercurial libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev unzip wget python file sudo -y && \
        rm -rf /var/lib/apt/lists/* && \
        mkdir -p /build && \
        useradd -ms /bin/bash build && \
        usermod -a -G sudo build && \
        chown -R build:build /build

USER build

WORKDIR /build

RUN git clone -b lede-17.01 https://git.openwrt.org/source.git lede && \
    git clone https://github.com/gl-inet/imagebuilder-lede-ramips imagebuilder && \
    git clone https://github.com/gl-inet/openwrt-files.git imagebuilder/files

ENV VERSION 0.4_mod

ADD https://github.com/shawly/fusee-lede/archive/${VERSION}.tar.gz /build/fusee-lede

RUN cp -r /build/fusee-lede/fusee-nano lede/package/utils/ && \
    mkdir -p /build/lede/target/linux/generic/patches-4.4/ && \
    cp /build/fusee-lede/899-ehci_enable_large_ctl_xfers.patch /build/lede/target/linux/generic/patches-4.4/ && \
    
COPY .config /build/lede

WORKDIR /build/lede

RUN ./scripts/feeds update -a && \
    ./scripts/feeds install -a

RUN make tools/install && make toolchain/install

RUN make package/fusee-nano/compile V=w && \
    make package/fusee-nano/install V=w && \
    cp bin/packages/mipsel_24kc/base/fusee-nano*.ipk ../imagebuilder/packages

# gl-mt300n-v2 imagebuilder image
FROM ubuntu:16.04

COPY --from=build /build/imagebuilder /build/imagebuilder

RUN apt-get update && \
    apt-get install subversion build-essential git-core libncurses5-dev zlib1g-dev gawk flex quilt libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs unzip git wget -y && \
        rm -rf /var/lib/apt/lists/* && \
        mkdir -p /build/imagebuilder/bin && \
        useradd -ms /bin/bash build && \
        usermod -a -G sudo build && \
        chown -R build:build /build

USER build

WORKDIR /build/imagebuilder

VOLUME /build/imagebuilder/bin

ENV LEDE_PACKAGES "kmod-mt7628 uci2dat mtk-iwinfo luci fusee-nano"

CMD make image PROFILE=gl-mt300n-v2 PACKAGES="${LEDE_PACKAGES}" FILES=files/files-clean-mt7628/
