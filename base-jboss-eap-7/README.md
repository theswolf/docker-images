docker run -ti --rm -e DISPLAY=$DISPLAY        \
        -v /tmp/.X11-unix:/tmp/.X11-unix       \
         -v $(pwd):/home/developer/opt/jboss-eap-7.0/standalone/deployments/        \
         -p 9990:9990 -p 9993:9993 -p 8009:8009 -p 8080:8080 -p 8443:8443 -p 4712:4712 -p 4713:4713 -p 8787:8787        \
         theswolf\base-jboss-eap7
