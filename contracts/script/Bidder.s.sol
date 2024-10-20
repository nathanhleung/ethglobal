// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Bidder} from "../src/Bidder.sol";

contract BidderScript is Script {
    Bidder public bidder;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        address LAYERZERO_LOCAL_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        bidder = new Bidder(LAYERZERO_LOCAL_ENDPOINT, msg.sender);

        vm.stopBroadcast();
    }
}
