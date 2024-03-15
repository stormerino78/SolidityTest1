// SPDX-License-Identifier: MIT
//MIT licenses are one of the least restrictives licenses
pragma solidity ^0.8.22; // We can use any version above 0.8.7 included

contract SimpleStorage {
    /* boolean, uint (positiv number), int, adress, bytes, string
    bool hasFavoriteNumber = true;
    string favoriteNumberInText = "Vingt trois";
    address myAdress = 0x3288D6E2e196DC57515eC5F89d18973a0fFc22b4;
    bytes32 favoriteBytes = "hello"; // ex bytes : 0x26R52738928019283012 */


    uint256 favoriteNumber; // Storage variable by deault cause not in a function
    People public person = People({favouiteNumber:2, name: 'Maria'});
    
    mapping(string => uint256) public nameToFavouriteNumber; // Mapping function (like a dictionnary) associating a value to a key

    struct People{
        uint256 favouiteNumber;
        string name;
    }

    People[] public people; //[] to make it a list
    //People[3] for a list of 3 elements
    function store(uint256 _favoriteNumber) public virtual { //virtual makes it overidable by ExtraStorage
        favoriteNumber = _favoriteNumber;
    }

    //view function 
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addperson(uint256 _favouriteNumber, string memory _name) public{
    People memory newPerson = People(_favouriteNumber, _name);
    people.push(newPerson); //push people to the list
    //or people.push(People(_favouriteNulber, _name));
    nameToFavouriteNumber[_name] = _favouriteNumber; //associate each number to the name in the mapping
    }
}
