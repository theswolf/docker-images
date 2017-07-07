# docker-studio

Android studio in docker container

## Requirements

* Docker 1.2+ (should work fine on 1.0+ but I haven't tried)
* An X11 socket

## Quickstart

studiod () 
{ 
    HOME_FOLDER=$HOME/docker/.code-studio;
    mkdir -p $HOME_FOLDER;
    docker start studio || docker run -d --cap-add=SYS_ADMIN -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/snd \
	-e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
	-v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
	--group-add $(getent group audio | cut -d: -f3) \
    -v $HOME_FOLDER:/home/developer -v /dev/bus/usb:/dev/bus/usb --privileged  \
    --name studio theswolf/docker-studio $@
}


## Help! I started the container but I don't see the  screen

You might have an issue with the X11 socket permissions since the default user
used by the base image has an user and group ids set to `1000`, in that case
you can run either create your own base image with the appropriate ids or run
`xhost +` on your machine and try again.
