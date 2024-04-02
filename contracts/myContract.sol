// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//I can use nutspec formst !!🥳
/// @author mosesmkrs

contract MyContract {
    string public name = "mosesmkrs";

    function updateName(string  memory _newName) public {
        name = _newName;
    }
}