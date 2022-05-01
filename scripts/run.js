
const { ethers } = require("hardhat");

const main = async () => {
    // const [owner, randomPerson] = await ethers.getSigners();
    const WaveContract = await ethers.getContractFactory("WavePortal");
    const waveContract = await WaveContract.deploy({value: ethers.utils.parseEther("0.1")}); // parseEther vs formatEther: parseEther turns a ether value into a wei big number value
    await waveContract.deployed();
    console.log("Contract has been deployed to:", waveContract.address);
    
    // Contract balance
    let contractBalance = await ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:", ethers.utils.formatEther(contractBalance));

    let waveTxn = await waveContract.wave("Message from creator!");
    await waveTxn.wait();

    contractBalance = await ethers.provider.getBalance(waveContract.address); // A promise that returns a big number
    console.log("Contract balance:", ethers.utils.formatEther(contractBalance)); // formatEther turns our big number into a ether value

    // const[_, randomPerson] = await ethers.getSigners();
    // waveTxn = await waveContract.connect(randomPerson).wave("Message from another person.");
    // await waveTxn.wait();

    // console.log(await waveContract.getAllWaves());

};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch(error) {
        console.log(error);
        process.exit(1);
    };
};

runMain();