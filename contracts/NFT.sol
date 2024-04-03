// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// IMPORTING NECESSARY FILES
    // IMPORTING CONTRACTS
import "@openzeppelin/contracts/access/Ownable.sol";
    // IMPORTING NFTS
import "./Interfaces/INFT.sol";
    // IMPORTING STRUCTS
import "./structs.sol";

contract NFTContract is Ownable, INFT{
    // DECLARE VARIABLES
    NFT public ownedNFT;
    uint public NFTPrice;
    address payable currentOwner;

    // A CONSTRUCTOR TO INSTANTIATE THE CONTRACT
    constructor(address _owner, NFT memory _NFT, uint _price) Ownable(_owner){
        ownedNFT = _NFT;
        NFTPrice = _price;
        currentOwner = payable(owner());
    }

    // A FUNCTION TO UPDATE THE PRICE
    function updatePrice(uint _newPrice) external onlyOwner{
        uint oldPrice = NFTPrice;
        NFTPrice = _newPrice;

        emit UpdatedPrice(oldPrice, _newPrice);
    }

    // A FUNCTION TO SELL THE NFT
    function sellNFT(string memory _name) external payable onlyOwner{
        // CARRY OUT TRANSACTION
        require(msg.value == NFTPrice, "Transaction failed, ensure your value is equal to current price");

        // IF NAME IS SENT, CHANGE IT
        if(keccak256(abi.encodePacked(_name)) != keccak256("")){
            ownedNFT.name = _name;
        }

        // TRANSFER OWNERSHIP OF NFT'S CONTRACT
        address oldOwner = owner();
        transferOwnership(msg.sender);

        emit SoldNFT(oldOwner, msg.sender);
    }

    // A FUNCTION TO WITHDRAW THE FUNDS
    function withdrawFunds() external onlyOwner{
        uint currentBalance = address(this).balance;
        (bool isSent, ) = currentOwner.call{value: currentBalance}("");
        
        require(isSent, "Funds not withdrawn successfully");
    }
}