FROM openjdk:8
MAINTAINER Chris Geymo "chris.geymo@gmail.com"

#RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
RUN  apt-get update && apt-get install -y software-properties-common && \
    #add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    #echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    #apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev unzip meld && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install libgtk as a separate step so that we can share the layer above with
# the netbeans image
RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module

ENV ANDROID_STUDIO_URL="https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip"
ADD $ANDROID_STUDIO_URL /tmp/tmp.zip


RUN unzip /tmp/tmp.zip -d /opt && rm /tmp/tmp.zip

ADD run /usr/local/bin/studio
RUN chmod +x /usr/local/bin/studio

RUN apt-get update && apt-get install -y sudo zip && rm -rf /var/lib/apt/lists/*

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
CMD /usr/local/bin/studio
