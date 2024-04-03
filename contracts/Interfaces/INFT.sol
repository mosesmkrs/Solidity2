// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface INFT {
    event SoldNFT(address indexed from, address indexed to);
    event UpdatedPrice(uint indexed oldPrice, uint indexed newPrice);

    function updatePrice(uint _newPrice) external;
    function sellNFT(string memory _name) external payable ;
    function withdrawFunds() external;
}