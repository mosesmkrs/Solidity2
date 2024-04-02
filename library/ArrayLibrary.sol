// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library ArrayLibrary{
    // A MODIFIER TO HANDLE EMPTY ARRAYS
    modifier OnlyNonEmpty(uint[] memory numbers){
        require(numbers.length != 0, "Array must not be empty");
        _;
    }

    // A FUNCTION THAT ENABLES .REDUCE FUNCTIONALITY
    ///@dev [1, 2, 3].filter((a, b) => a + b) = 6
    function reduce(
        uint[] memory _array, 
        function(uint, uint) internal pure returns(uint) _callback
    )internal pure OnlyNonEmpty(_array) returns(uint){
        uint accumulator = _array[0];

        // LOOP THROUGH ACCUMULATOR AND SECOND ELEMENT TO GET NEW ACCUMULATOR WITH FUNCTION PASSED
        for(uint i = 1; i < _array.length; i++){
            accumulator = _callback(accumulator, _array[i]);
        }

        return accumulator;
    }
}