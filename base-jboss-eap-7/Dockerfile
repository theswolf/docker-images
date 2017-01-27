FROM theswolf/base-java

USER root

RUN \
  apt-get update && \
  apt-get install -y unzip && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

USER developer

RUN mkdir -p /home/developer/opt
COPY ./lib/splitted /tmp/splitted

RUN cat  /tmp/splitted/* > /tmp/jboss-eap-7.0.0.zip

RUN unzip /tmp/jboss-eap-7.0.0.zip -d  /home/developer/opt

USER root
RUN rm  /tmp/jboss-eap-7.0.0.zip
RUN rm -Rf /tmp/splitted
USER developer

ENV PATH=$PATH:/home/developer/opt/jboss-eap-7.0/bin

RUN echo 'JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"' >>  /home/developer/opt/jboss-eap-7.0/bin/standalone.conf
RUN echo 'JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address=0.0.0.0"' >>  /home/developer/opt/jboss-eap-7.0/bin/standalone.conf

EXPOSE 9990 9993 8009 8080 8443 4712 4713 8787 

CMD ["bash"]
