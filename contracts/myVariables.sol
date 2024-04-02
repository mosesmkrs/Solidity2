// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//I can use nutspec formst !!🥳
/// @author mosesmkrs

contract MyVariables {
    int256 private myInt8 = -565878973739898000389998; // state that lives forever on the BC 

    address thisContractAddress = address(this);
    uint256 internal time = block.timestamp; //state storing global variable



    
}

contract NeedsVariables is MyVariables {
    uint8 goodVar = 100;
    uint256 theTime = time; 
}