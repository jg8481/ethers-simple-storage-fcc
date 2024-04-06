const ethers = require("ethers")
const fs = require("fs-extra")
require("dotenv").config()

// This Lesson5CodeSessions_interact.js or simply "interact.js" script is based on a similar simple test I wrote below.
//
// https://github.com/jg8481/Robot-Framework-Solidity-Testing-Toolkit/blob/main/solidity-hardhat-multichain-tools/tasks/interact.js
//
// The following example shows how to use this interact.js tool from your terminal.
//
// export CONTRACT_ADDRESS="0x3eb5bcabd2034f42901462ae3d5448b666096287"; node ./Lesson5CodeSessions_interact.js

async function main() {

    let provider = new ethers.JsonRpcProvider(process.env.RPC_URL)
    let signer = new ethers.Wallet(process.env.PRIVATE_KEY, provider)
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8")

    // The following line is my own creation and not part of Patrick Collins' original code.
    const contractTester = new ethers.Contract(process.env.CONTRACT_ADDRESS, abi, signer)
    console.log(" ")
    console.log(" ")
    console.log("====>>>> Test Run Starting : CONTRACT TESTER TOOL will start interacting with the deployed smart contract. <<<<====")
    console.log("The 'CONTRACT TESTER TOOL' in this interact.js script will quickly check the deployed SimpleStorage contract. By directly testing the Solidity functions.")
    console.log(" ")
    console.log(" ")
    let currentFavoriteNumber = await contractTester.retrieve()
    console.log(`Current Favorite Number: ${currentFavoriteNumber}`)
    console.log("Updating favorite number...")
    let transactionResponse = await contractTester.store(7)
    let transactionReceipt = await transactionResponse.wait()
    currentFavoriteNumber = await contractTester.retrieve()
    console.log(`New Favorite Number: ${currentFavoriteNumber}`)
    console.log(" ")
    console.log(" ")
    console.log("====>>>> Test Run Finished : CONTRACT TESTER TOOL has finished testing all Solidity functions of the smart contract. <<<<====")
    console.log(" ")
    console.log(" ")
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })