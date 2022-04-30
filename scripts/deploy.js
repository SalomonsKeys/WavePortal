const {ethers} = require("hardhat");

const main = async()=> {
    const [deployer] = await ethers.getSigners();
    const accountBalance = await deployer.getBalance();
    
    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());
    
    const Contract = await ethers.getContractFactory("WavePortal");
    const contract = await Contract.deploy();
    await contract.deployed();

    console.log("Contract Address:", contract.address);

}

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch(error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();