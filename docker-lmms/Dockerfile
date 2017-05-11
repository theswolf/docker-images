FROM buildpack-deps:yakkety
MAINTAINER Chris Geymo "chris.geymo@gmail.com"

##############SOFTWARE BLOCK########################

# Install required dependencies if needed
####################################################

RUN apt-get update && apt-get install -y apt-transport-https software-properties-common wget

# Download package file
RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.4.1~kxstudio1_all.deb

# Install it
RUN dpkg -i kxstudio-repos_9.4.1~kxstudio1_all.deb



# Install required dependencies if needed
RUN apt-get install -y libglibmm-2.4-1v5

# Download package file
RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.4.1~kxstudio1_all.deb

# Install it
RUN dpkg -i kxstudio-repos-gcc5_9.4.1~kxstudio1_all.deb

RUN apt-get update && apt-get install -y lmms lmms-common
####################################################

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

#COPY lombok.jar /opt/eclipse
#RUN echo '-javaagent:/opt/eclipse/lombok.jar' >> /opt/eclipse/eclipse.ini

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD lmms
