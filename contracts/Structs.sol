// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTING CONTRACTS
import "@openzeppelin/contracts/utils/Context.sol";

contract StructsContract is Context{
    // DECLARING STRUCTS
    struct NFT{
        string name;
        uint ID;
    }

    // DECLARING VARIABLES
    mapping(address => NFT[]) public addressToNFTMapping;
    uint public cooldownDuration;
    uint public lastMiningTime;
    uint currentIndex = 0;

    // CALLING CONSTRUCTOR TO SET A FUNCTION
    constructor(){
        cooldownDuration = 1 minutes;
    }

    // A FUNCTION TO MINT AN NFT
    function mintNFT(string memory _name) external{
        require(block.timestamp > lastMiningTime + cooldownDuration, "You can only mine after the cooldown period");
        
        uint NFTID = uint(keccak256(abi.encodePacked(_msgSender(), block.timestamp, currentIndex)));
        NFT memory minedNFT = NFT(_name, NFTID);
        addressToNFTMapping[_msgSender()].push(minedNFT);

        currentIndex++;
        lastMiningTime = block.timestamp;
    }

    // A FUNCTION TO IMPORT AN ARRAY OF NFTS
    function importNFTS(NFT[] calldata _importedNFTS) external{
        require(_importedNFTS.length != 0, "You must import at least one NFT");
        
        for(uint i = 0; i < _importedNFTS.length; i++){
            NFT memory currentNFT = _importedNFTS[i];
            addressToNFTMapping[_msgSender()].push(currentNFT);
        }
    }

    // A FUNCTION TO FIND THE NUMBER OF NFTS AN ADDRESS HAS
    function findTotalNFTS() external view returns(uint){
        return addressToNFTMapping[_msgSender()].length;
    }

    // A FUNCTION TO DELETE AN NFT
    function deleteNFT(uint _NFTID) external{
        NFT[] storage ownedNFTS = addressToNFTMapping[_msgSender()];
        
        for(uint i = 0; i < ownedNFTS.length; i++){
            if(ownedNFTS[i].ID == _NFTID){
                ownedNFTS[i] = ownedNFTS[ownedNFTS.length - 1];
                ownedNFTS.pop();
            }
        }
    }
}