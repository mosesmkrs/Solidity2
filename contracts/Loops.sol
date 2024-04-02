// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTING LIBRARIES
import "library/NumberArrayLibrary.sol";

contract LoopsContract{
    // DECLARING LIBRARIES
    using NumberArrayLibrary for uint[];

    // DECLARING VARIABLES
    uint[] public numbersArray;
    uint[] public resultsArray;

    // DECLARING PRIVATE FUNCTIONS
        // A FUNCTION TO FIND EVEN
    function _findEven(uint _number) private pure returns(bool){
        return _number % 2 == 0;
    }
        // A FUNCTION TO FIND ODD
    function _findOdd(uint _number) private pure returns(bool){
        return _number % 2 == 1;
    }
        // A FUNCTION TO FIND PRIME
    function _findPrime(uint _number) private pure returns(bool){
        if(_number == 1){
            return false;
        }

        for(uint i = 1; i <= _number; i++){
            if((i != 1) && (i != _number) && (_number % i == 0)){
                return false;
            }
        }

        return true;
    }

    // A FUNCTION TO SET NUMBERS ARRAY
    function setNumbersArray(uint[] memory _numbersArray) external{
        numbersArray = _numbersArray;
        resultsArray = new uint[](0);
    }

    // A FUNCTION TO FIND ODD NUMBERS IN AN ARRAY
    function findOdd() external{
        resultsArray = numbersArray.filter(_findOdd);
    }

    // A FUNCTION TO FIND EVEN NUMBERS IN AN ARRAY
    function findEven() external{
        resultsArray = numbersArray.filter(_findEven);
    }

    // A FUNCTION TO FIND PRIME NUMBERS IN AN ARRAY
    function findPrime() external{
        resultsArray = numbersArray.filter(_findPrime);
    }
}