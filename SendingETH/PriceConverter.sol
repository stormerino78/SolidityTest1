// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData(); //Get only the variable answer of the 5 variable returned by the function latestRouanData
        return uint256(answer * 1e10); //convert into uint256 and add decimals to match the payable return value (8+10 = 18decimals)
    }

    function convert(uint256 ethAmount) internal view returns(uint256){
        uint256 ValueUSD = (ethAmount*getPrice())/1e18;
        return ValueUSD;
    }
}