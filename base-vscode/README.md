Run with:
docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $(pwd):/home/developer
       theswolf/base-eclipse
