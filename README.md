# fusee-mt300n-v2
[![Build Status](https://travis-ci.org/shawly/fusee-mt300n-v2.svg?branch=master)](https://travis-ci.org/shawly/fusee-mt300n-v2) [![Project Status](https://img.shields.io/badge/status-wip-f39f37.svg)](https://github.com/shawly/fusee-mt300n-v2/releases) [![GitHub Release](https://img.shields.io/github/release/shawly/fusee-mt300n-v2.svg)](https://github.com/shawly/fusee-mt300n-v2/releases/latest)
Files for building a custom LEDE image with [fusee-nano](https://github.com/DavidBuchanan314/fusee-nano) for GL.iNet's GL-MT300N-v2. 

## System Requirement
1. Any linux distribution
2. Docker
3. Docker-Compose (optional)

## Compiling from source
1. Clone this repo
````
git clone https://github.com/shawly/fusee-mt300n-v2.git builder
cd builder
````

2. Building the image
via Docker:
````
docker build -t fusee/gl-mt300n-v2 .
docker run -v $(pwd)/bin:/build/imagebuilder/bin fusee/gl-mt300n-v2
````
via Docker Compose:
````
docker-compose up --build
````
building an image with custom packages:
````
docker build -t fusee/gl-mt300n-v2 .
# building the firmware with tor (if you want to use the router for more purposes than as a payload injector)
docker run -v $(pwd)/bin:/build/imagebuilder/bin fusee/gl-mt300n-v2 image PROFILE="gl-mt300n-v2" PACKAGES="kmod-mt7628 uci2dat mtk-iwinfo luci fusee-nano uhttpd ethtool blkid iwinfo block-mount curl gnupg iw jshn kmod-fs-ext4 kmod-fs-ntfs kmod-fs-vfat kmod-fs-ext4 ntfs-3g kmod-fs-hfs kmod-fs-hfsplus kmod-fs-reiserfs kmod-fuse kmod-loop kmod-gpio-button-hotplug kmod-leds-gpio kmod-ledtrig-default-on kmod-ledtrig-netdev kmod-ledtrig-timer kmod-lib-crc-ccitt kmod-lib-crc16 kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 kmod-usb-storage kmod-usb-uhci kmod-usb2 kmod-usb-ohci kmod-usb-net kmod-usb-net-cdc-ether kmod-usb-net-rndis kmod-usb-serial kmod-usb-serial-cp210x kmod-usb-serial-option kmod-usb-serial-wwan kmod-usb-acm usb-modeswitch comgt chat luci luci-lib-json luci-lib-nixio uhttpd-mod-lua uhttpd-mod-ubus usbutils wget tor tor-geoip tor-resolve tor-gencert" FILES=files/files-tor-mt7628/
````

3. Flash the image from `./bin/targets/ramips/mt7628/` to your GL-MT300N-v2

## Usage
Once installed, just plug in your switch in RCM mode, and the payload will get launched automagically!

To set a custom payload, replace `/usr/share/fusee-nano/payload.bin`. (`fusee.bin` is bundled as a default payload, from https://github.com/ktemkin/Atmosphere/tree/poc_nvidia/fusee)
