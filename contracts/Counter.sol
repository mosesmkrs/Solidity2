// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// IMPORTING NECESSARY CONTRACTS
import "@openzeppelin/contracts/access/Ownable.sol";

contract CounterContract is Ownable(msg.sender){
    // DECLARING VARIABLES
    uint public count = 0;
    bool public counterActivated = true;

    // A MODIFIER TO CHECK IF COUNT CAN BE UPDATED
    modifier onlyCounterActivated{
        require(counterActivated == true, "Counter can be updated only when activated");
        _;
    }

    // A FUNCTION TO UPDATE THE COUNTER ACTIVATED
    function setCounterActivated(bool _counterActivated) external onlyOwner{
        counterActivated = _counterActivated;
    }

    // A FUNCTION TO INCREASE OR DECREASE COUNT
    function increaseCount() external onlyCounterActivated{
        count++;
    }

    function decreaseCount() external onlyCounterActivated{
        count--;
    }
}