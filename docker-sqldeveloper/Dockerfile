FROM openjdk:8
MAINTAINER Chris Geymo "chris.geymo@gmail.com"

#RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
RUN  apt-get update && apt-get install -y software-properties-common && \
    #add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    #echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    #apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev libgtk-3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install libgtk as a separate step so that we can share the layer above with
# the netbeans image
RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module

#ARG INTELLIJ_LINK="https://download.jetbrains.com/idea/ideaIC-2017.1.tar.gz"

ADD splitted /tmp/splitted
RUN cat  /tmp/splitted/* > /tmp/sqldeveloper.tar.gz

RUN echo 'Installing SQL DEV' && \
    tar -xf /tmp/sqldeveloper.tar.gz -C /opt/ && \
    rm /tmp/sqldeveloper.tar.gz

ADD run /usr/local/bin/sqldeveloper
RUN chmod +x /usr/local/bin/sqldeveloper

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
CMD /usr/local/bin/sqldeveloper
