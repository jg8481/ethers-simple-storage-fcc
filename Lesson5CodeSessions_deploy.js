const ethers = require("ethers")
const fs = require("fs-extra")
require("dotenv").config()

async function main() {
    let provider = new ethers.JsonRpcProvider(process.env.RPC_URL)
    let wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider)
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.bin",
        "utf8"
    )
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
    await new Promise(resolve => setTimeout(resolve, 5000)) // This will pause for a few seconds.
    console.log("Deploying, please wait...")
    const contract = await contractFactory.deploy()
    // const deploymentReceipt = await contract.deployTransaction.wait(1)
    // Note from Josh: I had to disable this line above because it kept displaying an error from my terminal.
    await new Promise(resolve => setTimeout(resolve, 5000)) // This will pause for a few seconds.
    console.log(`Contract deployed`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
