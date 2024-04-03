// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IMain{
    event SoldNFT(address from, address indexed to);
    event UpdatedPrice(uint indexed oldPrice, uint indexed newPrice);

    function setCooldown(uint _period) external;
    function updatePrice(uint _newPrice) external;
    function mintNFT(string memory _name) external;
    function purchaseNFT(string memory _name, bytes16 _dna) external payable ;
    function withdrawFunds() external;  
}