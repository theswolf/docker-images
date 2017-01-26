FROM theswolf/base-java

# Install Java.
#http://eclipse.mirror.wearetriple.com//technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz
RUN mkdir -p /home/developer/bin
RUN wget http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz  && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /home/developer/bin && \
    rm /tmp/eclipse.tar.gz
ENV PATH=$PATH:/home/developer/bin/eclipse

# Define commonly used JAVA_HOME variable


# Define default command.
CMD ["bash"]