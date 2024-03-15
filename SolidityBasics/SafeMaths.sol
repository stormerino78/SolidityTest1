// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract safeMath{
    uint16 public bigNumber = 255;

    function add() public {
        unchecked {bigNumber = bigNumber + 1;}
    }
}