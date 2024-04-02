// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library NumberArrayLibrary{
    // A MODIFIER FOR THE ARRAYS
    modifier OnlyNonEmpty(uint[] memory _array){
        require(_array.length != 0, "The array must have a value");
        _;
    }

    // A FUNCTION TO FILTER THROUGH AN ARRAY OF NUMBERS
    ///@dev [1, 2, 3].filter(number => number == 2) = [2]
    function filter(
        uint[] memory _numbers, 
        function(uint) internal pure returns(bool) _callback
    )internal pure OnlyNonEmpty(_numbers) returns(uint[] memory){
        // DECLARING ARRAY TO HOLD FILTERED RESULTS AND A COUNTER FOR IT, EG [2,4,,,]
        uint[] memory filteredArray = new uint[](_numbers.length);
        uint currentIndex = 0;

        // LOOPING THROUGH THE ORIGINAL ARRAY AND FILLING UP FILTERED ARRAY WITH RESULTS
        for(uint i = 0; i < _numbers.length; i++){
            uint currentElement = _numbers[i];

            if(_callback(currentElement)){
                filteredArray[currentIndex] = currentElement;
                currentIndex++;
            }
        }

        // TRIMMING THE FILTERED ARRAY TO AN EXACT SIZE, EG[2,4]
        uint[] memory trimmedArray = new uint[](currentIndex);

        for(uint i = 0; i < currentIndex; i++){
            trimmedArray[i] = filteredArray[i];
        }

        // RETURNING TRIMMED ARRAY
        return trimmedArray;
    }
}