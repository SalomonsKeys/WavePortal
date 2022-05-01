// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "hardhat/console.sol";

//*** GENERATING A RANDOM NUMBER LIKE MAKES OUR LITTLE GAME VULNERABLE TO SOMEONE GAMING OUR SYSTEM */
// THERE ARE BETTER METHODS FOR RANDOM NUMBER GENERATION LIKE A CHAINLINK ORACLE
// THIS WAS JUST FOR A QUICK EASY RANDOM NUMBER FOR TESTING

contract WavePortal {
    uint totalWaves;

    uint private seed;

    event NewWave(address indexed from, uint indexed timestamp, string indexed message);

    struct Wave {
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] waves;

    // Records when was the last a user waved
    mapping(address => uint) public lastWavedAt;

    constructor() payable{
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        // We require the user to only send waves every 15 minutes
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15 min");

        // We update the timestamp of the user
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved with the message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        //Generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random number generated %d", seed);

        // Give a 50% chance that the user wins the prize
        if(seed <= 50) {
            console.log("%s won!", msg.sender);
            uint prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance);
            (bool success, ) = msg.sender.call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");
        }
        
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns(uint) {
        console.log("We have %s total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns(Wave[] memory) {
        return waves;
    }
}
