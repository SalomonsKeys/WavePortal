// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;

    event NewWave(address indexed from, uint indexed timestamp, string indexed message);

    struct Wave {
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] waves;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved with the message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        
        emit NewWave(msg.sender, block.timestamp, _message);

        uint prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance, "Trying to withdraw more than the contract has");
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getTotalWaves() public view returns(uint) {
        console.log("We have %s total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns(Wave[] memory) {
        return waves;
    }
}
