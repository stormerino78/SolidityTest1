// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

//GOAL:
// Get funds from users
// Withdraw all funds
// SET a minimum funding value in USD


//BASIC CODE (675k gas)

contract FundMe_basic{

    using PriceConverter for uint256;

    uint256 public minFundValueUSD = 50 * 1e18; //Match de decimals of ethereum

    address[] givers; //keep track of who sends money
    mapping(address=>uint256) findDonator;

    address public owner;

    constructor(){ // function called immediatly after deploying the contract (in the safe transaction as the deployment)
        owner = msg.sender;
    }

    function fund_basic() public payable { //enable people to send money to the contract
        //it's required to send at least 1eth, if not revert and display the error message
        require (msg.value.convert()>=minFundValueUSD, "Not enough funds sent");
        //require (msg.value>=1e18, "Not enough funds sent"); 1e18 == 1*10^18 == 1eth in wei
        givers.push(msg.sender); //add the address of each sender to the list givers
        findDonator[msg.sender] = msg.value; //map the address with the value of the sender
    } 

    function withdrawn_basic() public onlyOwner_basic {
        //resetting the mapping and the traces
        //for(starting index; ending index; step index){}
        for(uint256 giversIndex = 0; giversIndex<givers.length ; giversIndex++ /*giversIndex = giversIndex +1*/){
            address giver = givers[giversIndex];
            findDonator[giver] = 0;
        }
        //resetting the array with 0 objects in it
        givers = new address[](0);


        //withdraw the funds

        // 1st way: CALL (unlimited gas) RECOMMANDED WAY
        //allows to call function here empty with ("") and have the status of the call (bool) and the return of the function (bool callSuccess, bytes memory dataReturned)
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}(""); // return 2 variables
        require(callSuccess, "too much gas used");

        /* 2nd way: TRANSFER (caped at 2300 gas or revert and throw error)
        //msg.sender = address ; payable(msg.sender) = payable adress (able to send eth to this address)
        payable(msg.sender).transfer(address(this).balance);
        //payable(receiver_adress).transfer(amount_to_transfer);

        // 3rd way: SEND (caped at 2300 gas or rever and send bool)
        bool sendSuccess = payable(msg.sender).send(address(this).balance); // only revert with the require
        require(sendSuccess, "too much gas used"); //so it reverts if failed and get the gas back */
    }

    modifier onlyOwner_basic{
        require(msg.sender == owner, "sender is not the owner"); //only the owner of the contract can withdraw
        _; // doing the rest of the code (can't be place up the require)
    }
}


// ADVANCED Code (gas efficient)
error NotOwner();
error TooMuchGas();
error NotEnoughFund();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINFUNDUSD = 50 * 1e18; //Match de decimals of ethereum

    address[] givers; //keep track of who sends money
    mapping(address=>uint256) findDonator;

    address public immutable i_owner;

    constructor(){ // function called immediatly after deploying the contract (in the safe transaction as the deployment)
        i_owner = msg.sender;
    }

    function fund() public payable { //enable people to send money to the contract
        //it's required to send at least MINFUNDUSD, if not revert and display the error message
        if(msg.value.convert()<MINFUNDUSD){revert NotEnoughFund();}
        givers.push(msg.sender); //add the address of each sender to the list givers
        findDonator[msg.sender] = msg.value; //map the address with the value of the sender
    } 

    function withdrawn() public onlyOwner {
        //resetting the mapping and the traces
        //for(starting index; ending index; step index){}
        for(uint256 giversIndex = 0; giversIndex<givers.length ; giversIndex++ /*giversIndex = giversIndex +1*/){
            address giver = givers[giversIndex];
            findDonator[giver] = 0;
        }
        //resetting the array with 0 objects in it
        givers = new address[](0);


        //withdraw the funds

        // 1st way: CALL (unlimited gas) RECOMMANDED WAY
        //allows to call function here empty with ("") and have the status of the call (bool) and the return of the function (bool callSuccess, bytes memory dataReturned)
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}(""); // return 2 variables
        if(!callSuccess){revert TooMuchGas();}
        revert();
        /* 2nd way: TRANSFER (caped at 2300 gas or revert and throw error)
        //msg.sender = address ; payable(msg.sender) = payable adress (able to send eth to this address)
        payable(msg.sender).transfer(address(this).balance);
        //payable(receiver_adress).transfer(amount_to_transfer);

        // 3rd way: SEND (caped at 2300 gas or rever and send bool)
        bool sendSuccess = payable(msg.sender).send(address(this).balance); // only revert with the require
        require(sendSuccess, "too much gas used"); //so it reverts if failed and get the gas back */
    }

    modifier onlyOwner{
        if(msg.sender != i_owner){revert NotOwner();}
        _;
    }
}

