// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./Simplestorage.sol";

contract StorageFactory{
    
    SimpleStorage[] public simplestorageList;

    function createSimplestorageContract() public {
        SimpleStorage simplestorage = new SimpleStorage(); // The new indicates here to solidity the creation of a new contract
        simplestorageList.push(simplestorage);
    }

    function manageStore(uint256 _simplestorageIndex, uint256 _simplestorageNumber) public {
        SimpleStorage simpleStorage = simplestorageList[_simplestorageIndex]; //Store in the variable the N°i contract
        //SimpleStorage simplestorage = SimpleStorage(simplestorageList[_simplestorageIndex]); if adress[] public simplestorageList;
        simpleStorage.store(_simplestorageNumber);
    }

    function checkSimpleStorage(uint256 _simplestorageIndex) public view returns(uint256){
        //SimpleStorage simpleStorage = simplestorageList[_simplestorageIndex];
        //return simpleStorage.retrive();
        return simplestorageList[_simplestorageIndex].retrieve();
    }
}