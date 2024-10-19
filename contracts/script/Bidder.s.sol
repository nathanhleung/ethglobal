// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Bidder} from "../src/Bidder.sol";

contract BidderScript is Script {
    Bidder public bidder;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        bidder = new Bidder();

        vm.stopBroadcast();
    }
}
