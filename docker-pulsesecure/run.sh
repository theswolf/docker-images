#!/bin/bash
BB_USER='christiangeymonat'
BB_PASS='scaifactory'
IFG_USER='IG06257'
IFG_PASS='Azzurro2016'
BRANCH_ORIGIN='BRANCH_FILIALI_ESTERE'
BRANCH_DEST='BRANCH_SYSTEM'
EXCLUDED_COPY='.git/,*.yml'
COMMIT_MESSAGE='auto merge'

#curl -H "Content-Type: application/json" --data '{"source_type": "Branch", "source_name": "docker-pulsesecure"}' -X POST https://registry.hub.docker.com/u/scaifactorydev/docker-repo/trigger/c21d3817-7b02-4146-b2e2-a064a74eff29/
docker login -u scaifactorydev -p Scaifactory_1
docker pull scaifactorydev/docker-repo:docker-pulsesecure

docker run -it --rm -e BB_USER=$BB_USER  -e COMMIT_MESSAGE="$COMMIT_MESSAGE" \
-e BB_PASS=$BB_PASS -e IFG_USER=$IFG_USER -e IFG_PASS=$IFG_PASS \
-e BRANCH_ORIGIN=$BRANCH_ORIGIN -e BRANCH_DEST=$BRANCH_DEST -e EXCLUDED_COPY=$EXCLUDED_COPY  --privileged scaifactorydev/docker-repo:docker-pulsesecure  
