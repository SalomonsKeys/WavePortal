
const { ethers } = require("hardhat");

const main = async () => {
    // const [owner, randomPerson] = await ethers.getSigners();
    const WaveContract = await ethers.getContractFactory("WavePortal");
    const waveContract = await WaveContract.deploy();
    await waveContract.deployed();
    console.log("Contract has been deployed to:", waveContract.address);
    console.log("Contract deployed by:", waveContract.address);

    let waveTxn = await waveContract.wave("Message from creator!");
    await waveTxn.wait();

    const[_, randomPerson] = await ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Message from another person.");
    await waveTxn.wait();

    console.log(await waveContract.getAllWaves());

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