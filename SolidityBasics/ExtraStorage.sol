// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./Simplestorage.sol";

contract ExtraStorage is SimpleStorage{ //inherit all functionnalities of simple storage

    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}