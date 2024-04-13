These are my notes while working on [Patrick's Javascript Blockchain/Smart Contract FreeCodeCamp Course](https://www.youtube.com/watch?v=gyMwXuJrbJQ).

- On April 6, 2024 successfully compiled and deployed the following "EthersJS smart contract deployment and interaction" example code to interact with a locally installed Ganache fake blockchain node. I created a customziable set of build automation scripts that I will re-use in other sections of Patrick's YouTube course.
![alt text](./notes/image1.png)

- On April 6, 2024 successfully compiled and deployed the following "EthersJS smart contract deployment and interaction" example code to the following address on Sepolia Testnet using my own Alchemy Sepolia Testnet RPC.
  - https://sepolia.etherscan.io/address/0x113ff797b286357c1a240b1f150f2b220f254d57
---
### Technical Requirements

Check the basic technical requirements from Patrick's original GitHub repo. For convenience, MacOS users can run `bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux` from the root of this repo to help quickly install the required tools.

### Quick Start Script

After the basic technical requirements are installed and working, then you can run the `bash ./Lesson5CodeSessions_start-automation-build-pipeline.sh` script. This automation script will start a sequence of the scripts listed below, and is meant to behave like a typical build pipeline.

### Current Toolkit Capabilities
```
You can view just this help menu again (without triggering any automation) by running 'bash ./Lesson5CodeSessions_start-deployment-scripts.sh -h' or 'bash ./Lesson5CodeSessions_start-deployment-scripts.sh -h --help'.

bash ./Lesson5CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-And-Delete-Logs
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Yarn
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Deployment-On-Ganache-Node
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Start-EthersJS-Interact-Test"

If you're running this for the first time run the following before running Start-EthersJS-Deployment-On-Ganache-Node.

bash ./Lesson5CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux
bash ./Lesson5CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Yarn
```
