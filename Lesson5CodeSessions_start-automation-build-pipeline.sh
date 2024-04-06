#! /bin/bash

clear
TIMESTAMP=$(date)
CURRENT_DIRECTORY=$(pwd)
cd "$CURRENT_DIRECTORY"
rm -rf ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "This automation build pipeline run started on $TIMESTAMP." >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "SETUP STAGE :: CLEAN THE BUILD ENVIRONMENT" >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-And-Delete-Logs >> ./logs/solc-etherjs-build-pipeline.log &&
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "BUILD STAGE 1 :: INSTALL THE REQUIRED TOOLS" >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
sleep 2
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux >> ./logs/solc-etherjs-build-pipeline.log &&
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "BUILD STAGE 2 :: COMPILE THE SOLIDITY CODE AND CHECK BUILD ARTIFACTS" >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
sleep 2
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Yarn >> ./logs/solc-etherjs-build-pipeline.log &&
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "BUILD STAGE 3 :: DEPLOY THE SMART CONTRACT(S) TO A LOCAL BLOCKCHAIN NODE" >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
sleep 2
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Deployment-On-Ganache-Node >> ./logs/solc-etherjs-build-pipeline.log &&
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "BUILD STAGE 4 :: TEST THE DEPLOYED SMART CONTRACT(S) ON A LOCAL BLOCKCHAIN NODE" >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
sleep 2
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Interact-Test >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
echo "This automation build pipeline run ended on $TIMESTAMP." >> ./logs/solc-etherjs-build-pipeline.log
echo >> ./logs/solc-etherjs-build-pipeline.log
cat ./logs/solc-etherjs-build-pipeline.log
exit