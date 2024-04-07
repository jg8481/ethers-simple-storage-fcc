#! /bin/bash

clear
TIMESTAMP=$(date)

if [ "$1" == "Stop-Local-Blockchain-Nodes-And-Delete-Logs" ]; then
  echo
  echo "------------------------------------[[[[ Stop-Local-Blockchain-Nodes-And-Delete-Logs ]]]]------------------------------------"
  echo
  echo "This command will stop any locally running network nodes and clean up any logs leftover from old runs. Feel free to run this command multiple times to clean up files listed below. This run started on $TIMESTAMP."
  echo
  killall ganache > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill ganache > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  ps aux | grep ganache
  rm -rf ./logs/*.log
  rm -rf ./logs/*.json
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Install-Tools-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Install-Tools-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command will install all of the required Node.js packages. This script was created on MacOS, but can be used in any Linux Distro that has curl installed. This run started on $TIMESTAMP."
  echo
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &&
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 18
  nvm use 18
  nvm alias default 18
  node --version
  npm install npm --global
  npm update
  npm install yarn -g
  npm uninstall -g ganache-cli 
  npm uninstall ganache-cli 
  npm uninstall ganache
  npm uninstall ganache -g &&
  npm install ganache -g
  npm update
  yarn info
  yarn install
  ## If there are no serious issues with your local install, do not un-comment the following line.
  #npm audit fix --force
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Compile-Solidity-Code-With-Yarn" ]; then
  echo
  echo "------------------------------------[[[[ Compile-Solidity-Code-With-Yarn ]]]]------------------------------------"
  echo
  echo "This command will run the Compile-Solidity-Code-With-Yarn script. This run started on $TIMESTAMP."
  echo
  yarn compile
  if [ -n "$(ls -la | grep SimpleStorage | grep bin)" ]; then
     echo
     echo 
     echo "BUILD ARTIFACT DETECTED: Solidity bin compilation success."
     echo
     echo 
  else
     echo
     echo 
     echo "BUILD FAILURE: Solidity bin compilation failed."
     echo
     echo
     exit 1
  fi  
  if [ -n "$(ls -la | grep SimpleStorage | grep abi)" ]; then
     echo
     echo 
     echo "BUILD ARTIFACT DETECTED: Solidity abi compilation success."
     echo
     echo 
  else
     echo
     echo 
     echo "BUILD FAILURE: Solidity abi compilation failed."
     echo
     echo
     exit 1
  fi  
  ls -la | grep SimpleStorage
  sleep 2
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-EthersJS-Deployment-On-Ganache-Node" ]; then
  echo
  echo "------------------------------------[[[[ Start-EthersJS-Deployment-On-Ganache-Node ]]]]------------------------------------"
  echo
  echo "This command will run the Start-EthersJS-Deployment-On-Ganache-Node script. This part of the script requires jq to be installed (https://github.com/jqlang/jq). This run started on $TIMESTAMP."
  echo
  killall ganache > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill ganache > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  rm -rf ./ganache-private-keys.json
  rm -rf ./logs/ganache-private-keys.json
  sleep 4
  ganache --account_keys_path ganache-private-keys.json > ./logs/ganache-node-standalone-mode.log &
  sleep 4
  # source ./.env
  # For real PRIVATE_KEY and real RPC_URL values use the provided .env.example to create your own .env file instead of the following local testing values.
  export PRIVATE_KEY=$(cat ganache-private-keys.json | jq .private_keys | head -2 | tail -1 | awk '{ print $2 }' | tr -d '"' | tr -d ',')
  export RPC_URL="http://0.0.0.0:8545"
  # ^ The current fake RPC_URL and fake PRIVATE_KEY come from the Ganache fake blockchain node.
  sleep 2
  node ./Lesson5CodeSessions_deploy.js
  sleep 2
  cp ./ganache-private-keys.json ./logs/ganache-private-keys.json
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-EthersJS-Interact-Test" ]; then
  echo
  echo "------------------------------------[[[[ Start-EthersJS-Interact-Test ]]]]------------------------------------"
  echo
  echo "This command will run the Start-EthersJS-Interact-Test script. This run started on $TIMESTAMP."
  echo
  # source ./.env
  # For real PRIVATE_KEY and real RPC_URL values use the provided .env.example to create your own .env file instead of the following local testing values.
  export PRIVATE_KEY=$(cat ganache-private-keys.json | jq .private_keys | head -2 | tail -1 | awk '{ print $2 }' | tr -d '"' | tr -d ',')
  export RPC_URL="http://0.0.0.0:8545"
  export CONTRACT_ADDRESS=$(cat ./logs/ganache-node-standalone-mode.log | grep "created" | awk '{ print $3 }')
  # ^ The current fake RPC_URL, fake CONTRACT_ADDRESS, and fake PRIVATE_KEY come from the Ganache fake blockchain node.
  sleep 2
  node ./Lesson5CodeSessions_interact.js
  rm -rf ./ganache-private-keys.json
  sleep 2
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "This tool runner script can be used to run the following commands to deploy the Solidity examples from the Patrick Collins FCC Solidity YouTube course."
  echo
  echo "You can view just this help menu again (without triggering any automation) by running 'bash ./Lesson5CodeSessions_start-deployment-scripts.sh -h' or 'bash ./Lesson5CodeSessions_start-deployment-scripts.sh -h --help'."
  echo
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-And-Delete-Logs"
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux"
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Yarn"
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Deployment-On-Ganache-Node"
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Interact-Test"
  echo
  echo "If you're running this for the first time run the following before running Start-EthersJS-Deployment-On-Ganache-Node."
  echo
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux"
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Yarn"
  echo
  echo "Then you can run the following combined commands in your terminal to deploy the contract to the Ganache local blockchain node."
  echo
  echo "bash ./Lesson5CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-And-Delete-Logs && bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Deployment-On-Ganache-Node"
  echo
  echo "You can also use the provided Lesson5CodeSessions_start-automation-build-pipeline.sh to run all the above commands in a sequence similar to a build pipeline."
  echo
  echo "bash ./Lesson5CodeSessions_start-automation-build-pipeline.sh"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi
