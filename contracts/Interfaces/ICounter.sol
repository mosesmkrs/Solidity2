// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface ICounter{
    function setTransactionCost(uint _value) external ;
    function setCounterActivated(bool _counterActivated) external;
    function increaseCount() external payable ;
    function decreaseCount() external payable ;
}