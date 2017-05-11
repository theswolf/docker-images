#!/bin/bash
#docker run -it --rm -e BB_USER='christiangeymonat' -e BB_PASS='scaifactory' -e IFG_USER='IG06257' -e IFG_PASS='Azzurro2016' -e BRANCH_ORIGIN='BRANCH_FILIALI_ESTERE' -e BRANCH_DEST='BRANCH_SYSTEM' -e EXCLUDED_COPY='.git,*.yml' --privileged
#git  -c http.sslVerify=false clone https://IG06257:Azzurro2016@src.servizi.infogroup.it/scm/git/06/SOGE0.git

#DA IFG SYSTEM MERGE SUL NOSTRO FILIALI_ESTERE
set -e
printenv
git clone -c http.sslVerify=false -b $BRANCH_ORIGIN https://$BB_USER:$BB_PASS@bitbucket.org/scaifinancedev/afe-sviluppo2017.git #afe-sviluppo2017
echo $IFG_PASS | sudo openconnect --juniper --passwd-on-stdin -b -u $IFG_USER vpn-fi.infogroup.it/dana-na/auth/url_3/login.cgi
sleep 5
git clone -c http.sslVerify=false -b $BRANCH_DEST https://$IFG_USER:$IFG_PASS@src.servizi.infogroup.it/scm/git/06/SOGE0.git #SOGE0

cd afe-sviluppo2017
git remote add SOGE0 /home/developer/SOGE0
git fetch SOGE0
git merge --allow-unrelated-histories SOGE0/$BRANCH_DEST # or whichever branch you want to merge
git remote remove SOGE0
#NOSTRO FILIALI ESTERE CP SU IFG FILIALI ESTERE
cd ../SOGE0 && git checkout -b $BRANCH_ORIGIN
#rsync -avz --exclude="{$EXCLUDED_COPY}" /home/developer/afe-sviluppo2017/ /home/developer/SOGE0/

RSYNC_EXCLUDE=""
for i in $(echo $EXCLUDED_COPY | tr "," "\n")
do
  RSYNC_EXCLUDE="$RSYNC_EXCLUDE --exclude=$i"
  #echo $RSYNC_EXCLUDE
done
RSYNC_CMD="rsync -avz $RSYNC_EXCLUDE /home/developer/afe-sviluppo2017/ /home/developer/SOGE0/"
eval $RSYNC_CMD

cd ./soge0_SRC/SRC/Project-soge0
cp build.xml build.xml.or
cp ./properties_build/buildInfoGroup.properties ./properties_build/buildInfoGroup.properties.or
cp /home/developer/buildInfoGroup.properties ./properties_build/buildInfoGroup.properties
sed -i 's/<javac /<javac encoding="iso-8859-1"/g' build.xml
ant ifg -Dant.build.javac.target=1.6 -Dant.build.javac.source=1.6
mv build.xml.or build.xml
mv ./properties_build/buildInfoGroup.properties.or ./properties_build/buildInfoGroup.properties
cd /home/developer/SOGE0
echo '**/soge.ear' >> .gitignore

if [ -n "$(git status --porcelain)" ]; then 
  git add .
  git commit -am "$(date +%s%N) - $COMMIT_MESSAGE"
else 
  echo "no changes";
fi

#MERGE IFG FILIALI ESTERE SU IFG SYSTEM
git checkout $BRANCH_DEST
git merge $BRANCH_ORIGIN
if [ -n "$(git status --porcelain)" ]; then 
  git add .
  git commit -am "$(date +%s%N) - $COMMIT_MESSAGE"
else 
  echo "no changes";
fi
#MERGE IFG SYSTEM SUN NOSTRO SYSTEM
cd /home/developer/afe-sviluppo2017
git checkout $BRANCH_DEST
git remote add SOGE0 /home/developer/SOGE0
git fetch SOGE0
git merge --allow-unrelated-histories SOGE0/$BRANCH_DEST # or whichever branch you want to merge
git remote remove SOGE0
if [ -n "$(git status --porcelain)" ]; then 
  git add .
  git commit -am "$(date +%s%N) - $COMMIT_MESSAGE"
else 
  echo "no changes";
fi

echo 'SUCCESS'