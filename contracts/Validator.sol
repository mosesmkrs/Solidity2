// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract ValidatorContract{
    // DEFINING VARIABLES
    int8 public firstNumber;
    int16 public secondNumber;

    // FUNCTIONS TO SET THE FIRST AND SECOND NUMBERS
    function setFirstNumber(int8 _number) external{
        if(_number == 10){
            revert("Ensure the first number is not equal to 10");
        }

        firstNumber = _number;
    }

    function setSecondNumber(int16 _number) external{
        secondNumber = _number;
    }

    // A FUNCTION TO ADD THE TWO NUMBERS
    function addNumbers() public view returns(int16){
        require(firstNumber < secondNumber, "First number should be less than the second");
        int16 total = firstNumber + secondNumber;
        assert(total > secondNumber);

        return total;
    }
}