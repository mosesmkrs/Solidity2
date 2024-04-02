// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract MappingsContract{
    // DECLARING VARIABLES
    mapping (address => uint[]) public addressesToNfts;
    uint public lastMiningTime;
    uint cooldownTime;
    uint countIndex = 0;

    // DECLARING EVENTS
    event NftMined(address indexed _address, uint indexed nftID);

    // DECLARING A CONSTRUCTOR TO SET COOLDOWN TIME
    constructor(){
        cooldownTime = 5 seconds;
    }

    // A FUNCTION TO MINT AN NFT
    function mintNft() external{
        require(block.timestamp > lastMiningTime + cooldownTime, "You need to mine after the cooldown");
        uint nftID = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, countIndex)));
        
        addressesToNfts[msg.sender].push(nftID);
        emit NftMined(msg.sender, nftID);
        
        countIndex++;
        lastMiningTime = block.timestamp;
    }
}