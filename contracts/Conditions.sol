// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTING LIBRARIES
import "@openzeppelin/contracts/utils/math/Math.sol";

contract ConditionsContract{
    // DECLARING LIBRARIES
    using  Math for uint8;

    // DECLARING VARIABLES
    uint8 public currentCounter = 0;
    string private _secretMessage = "You cracked the code";

    // A FUNCTION TO GET THE SECRET
    function getSecret() external view returns(string memory){
        require(currentCounter > 10 && currentCounter < 20, "Counter should be between 10 and 20");
        return _secretMessage;
    }

    // A FUNCTION TO UPDATE THE COUNTER
    function updateCounter() external{
        (bool mathStatus, uint answer) = currentCounter.tryAdd(1);

        if(!mathStatus){
            return;
        }

        currentCounter = uint8(answer);
    }
}