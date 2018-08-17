# fusee-mt300n-v2
Files for building a custom LEDE image for GL.iNet's GL-MT300N-v2.

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

3. Flash the image from `./bin/targets/ramips/mt7628/` to your GL-MT300N-v2

## Usage
Once installed, just plug in your switch in RCM mode, and the payload will get launched automagically!

To set a custom payload, replace `/usr/share/fusee-nano/payload.bin`. (`fusee.bin` is bundled as a default payload, from https://github.com/ktemkin/Atmosphere/tree/poc_nvidia/fusee)
