// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol";
import "library/ArrayLibrary.sol";

contract Calculator{
    using Math for uint;
    using ArrayLibrary for uint[];

    // DEFINING STRUCTS
    // A STRUCT TO HOLD DETAILS ON THE RESULT
    struct ArrayData{
        uint mean;
        uint mode;
        
        uint totalItems;
    }
        // A STRUCT TO HOLD DETAILS ON EACH NUMBER
    struct ArrayElementData{
        uint8 repeatedTimes;
        uint value;
    }

    // DEFINING VARIABLES
    uint public result = 0;
    ArrayData public statsAnswer = ArrayData(0, 0, 0);
    mapping (uint => ArrayElementData) private _numberToStatElement;

    // PRIMARY FUNCTIONS
        // A PRIMARY FUNCTION TO SHOW ADDING
    function _add(uint a, uint b) internal pure returns(uint){
        (, uint answer) = a.tryAdd(b);
        return answer;
    }
        // A PRIMARY FUNCTION TO SHOW SUBTRACTING
    function _subtract(uint a, uint b) internal pure returns(uint){
        (, uint answer) = a.trySub(b);
        return answer;
    }
        // A PRIMARY FUNCTION TO SHOW MULTIPLYING
    function _multiply(uint a, uint b) internal pure returns(uint){
        (, uint answer) = a.tryMul(b);
        return answer;
    }
        // A PRIMARY FUNCTION TO SHOW DIVIDING
    function _divide(uint a, uint b) internal pure returns(uint){
        (, uint answer) = a.tryDiv(b);
        return answer;
    }

    // A FUNCTION TO ADD NUMBERS
    function add(uint[] calldata _values) external{
        // IF ARRAY LACKS VALUES, RETURN THE ANSWER
        if(_values.length == 0){
            return; 
        }

        result = _values.reduce(_add);
    }

    // A FUNCTION TO SUBTRACT NUMBERS
    function subtract(uint[] calldata _values) external{
        // IF ARRAY LACKS VALUES, RETURN THE ANSWER
        if(_values.length == 0){
            return; 
        }

        result = _values.reduce(_subtract);
    }

    // A FUNCTION TO MULTIPLY NUMBERS
    function multiply(uint[] calldata _values) external{
        // IF ARRAY LACKS VALUES, RETURN THE ANSWER AS 0
        if(_values.length == 0){
            result = 0;
            return; 
        }

        result = _values.reduce(_multiply);
    }

    // A FUNCTION TO DIVIDE NUMBERS
    function divide(uint[] calldata _values) external{
        // IF ARRAY LACKS VALUES, RAISE AN ERROR
        require(_values.length != 0, "You cannot divide by zero");
        result = _values.reduce(_divide);
    }

    // A FUNCTION TO FIND MEAN, MODE, MEDIAN AND AVERAGE
    function stats(uint[] calldata _values) external returns(ArrayData memory){
        uint numberToStatElementSize = 0;
        uint totalSum = 0;
        uint maxRepeatedTimes = 0;

        // INITIATING THE NEWVALUES MAPPING FOR EACH NUMBER IN THE VALUES ARRAY
        for(uint i = 0; i < _values.length; i++){
            uint currentValue = _values[i];
            
            // IF IT WAS NOT RECORDED, RECORD IT AND INCREASE UNIQUE SIZE
            if(_numberToStatElement[currentValue].repeatedTimes == 0){
                _numberToStatElement[currentValue] = ArrayElementData(1, currentValue);
                numberToStatElementSize++;
            // IF RECORDED, INCR REPEATED TIMES AND CHECK IF LARGER THAN PREVIOUS REPEATED, 
            // IF SO THAT VALUE SO FAR IS THE MODE AND ASSIGN NEW REPEATED VALUE
            }else{
                _numberToStatElement[currentValue].repeatedTimes++;

                if(_numberToStatElement[currentValue].repeatedTimes > maxRepeatedTimes){
                    statsAnswer.mode = _numberToStatElement[currentValue].value;
                    maxRepeatedTimes = _numberToStatElement[currentValue].repeatedTimes;
                }
            }

            // ADD TOTAL SUM IRREGARDLESS
            totalSum += currentValue;
        }

    // Calculate mean
    if (numberToStatElementSize > 0) {
        // (, uint answer) = totalSum.tryDiv(numberToStatElementSize);
        statsAnswer.mean = totalSum;
    }

    // Set total items
    statsAnswer.totalItems = numberToStatElementSize;

    return statsAnswer;
    }
}