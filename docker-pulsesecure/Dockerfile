FROM buildpack-deps:zesty
MAINTAINER Chris Geymo "chris.geymo@gmail.com"

RUN  apt-get update && apt-get install -y gdebi

ARG PULSELINK=https://wiki.unitn.it/_media/pub:vpn:ps-pulse-linux-8.2r4.0-b47329-ubuntu-debian-installer.deb
#ARG MSSLINK=http://ftp.us.debian.org/debian/pool/main/n/nss-mdns/libnss-mdns_0.10-6_i386.deb


#RUN apt-get purge lib32nss-mdns && apt-get -fy dist-upgrade

#RUN dpkg --add-architecture i386 && \
#apt-get update && \
#apt-get install -y libwebkitgtk-1.0-0:i386 
#libc6-i386 lib32z1 lib32stdc++6 libnss-mdns 
#RUN LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/i386-linux-gnu && \
#export LD_LIBRARY_PATH


#RUN apt-get install wget && wget $PULSELINK -O /tmp/pulsesecure.deb && \
#     echo 'Installing pulsesecure' && \
#     gdebi  --option=APT::Get::force-yes=1,APT::Get::Assume-Yes=1 -n /tmp/pulsesecure.deb

#RUN /usr/local/pulse/PulseClient.sh install_dependency_packages

#RUN apt-get update && apt-get install -y sudo lib32z1 automake libtool liblz4-1 libxml2-dev && \
RUN apt-get update && apt-get install -y sudo openconnect && \
rm -rf /var/lib/apt/lists/*

#RUN mkdir -p /etc/vpnc/ && wget http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script -O /etc/vpnc/vpnc-script
#RUN git clone git://git.infradead.org/users/dwmw2/openconnect.git
#RUN cd openconnect && ls -alh && \
#./autogen.sh && \
#./configure && \
#make && \
#make install

RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

ADD VeriSignClass3PublicPrimaryCertificationAuthority-G5.crt /VeriSignClass3PublicPrimaryCertificationAuthority-G5.crt
ADD SymantecClass3SecureServerCA-G4.crt /SymantecClass3SecureServerCA-G4.crt
ADD vpn-fiinfogroupit.crt /vpn-fiinfogroupit.crt

RUN  cp /VeriSignClass3PublicPrimaryCertificationAuthority-G5.crt /usr/local/share/ca-certificates/VeriSignClass3PublicPrimaryCertificationAuthority-G5.crt
RUN  cp /SymantecClass3SecureServerCA-G4.crt /usr/local/share/ca-certificates/SymantecClass3SecureServerCA-G4.crt
RUN  cp /vpn-fiinfogroupit.crt /usr/local/share/ca-certificates/vpn-fiinfogroupit.crt

RUN update-ca-certificates
USER developer
ENV HOME /home/developer
WORKDIR /home/developer
#https://vpn-fi.infogroup.it/dana-na/auth/url_3/welcome.cgi
#/usr/local/pulse/PulseClient.sh -h secure.company.com -u user01 -p password01 
#-U https://secure.company.com/linux -r Realm -f secure.company.com.der
#CMD /usr/local/pulse/PulseClient.sh -h vpn-fi.infogroup.it -u IG06257 -p Azzurro2016 \
#-U https://vpn-fi.infogroup.it/dana-na/auth/url_3/login.cgi -r ActiveDirectory_Esterni-IG
#-U https://vpn-fi.infogroup.it/dana-na/auth/url_3/welcome.cgi 
#-U https://vpn-fi.infogroup.it/dana-na/auth/url_3/login.cgi
#-f /home/developer/vpn-fiinfogroupit.crt
CMD echo Azzurro2016 | sudo openconnect --juniper --passwd-on-stdin -b -u IG06257 vpn-fi.infogroup.it/dana-na/auth/url_3/login.cgi && \
git  -c http.sslVerify=false clone https://IG06257:Azzurro2016@src.servizi.infogroup.it/scm/git/06/SOGE0.git
