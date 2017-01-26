FROM theswolf/base-dev

# Install Java.
#http://eclipse.mirror.wearetriple.com//technology/epp/downloads/release/neon/2/eclipse-jee-neon-2-linux-gtk-x86_64.tar.gz
RUN mkdir -p /home/developer/bin
# vscode dependencies 
USER root
RUN apt-get update
RUN apt-get -y --no-install-recommends install libc6-dev libgtk2.0-0 libgtk-3-0 libpango-1.0-0 libcairo2 libfontconfig1 libgconf2-4 libnss3 libasound2 libxtst6 unzip libglib2.0-bin libcanberra-gtk-module libgl1-mesa-glx curl build-essential gettext libstdc++6 software-properties-common wget git xterm automake libtool autogen nodejs libnotify-bin aspell aspell-en htop git emacs mono-complete gvfs-bin libxss1 rxvt-unicode-256color x11-xserver-utils sudo vim

RUN wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868
RUN dpkg -i vscode-amd64.deb
RUN rm vscode-amd64.deb

USER developer
# Define commonly used JAVA_HOME variable


# Define default command.
CMD ["bash"]