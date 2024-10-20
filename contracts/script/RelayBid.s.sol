// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {RelayBid} from "../src/RelayBid.sol";

contract RelayBidScript is Script {
    RelayBid public relayBid;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        address LAYERZERO_SEPOLIA_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        relayBid = new RelayBid(LAYERZERO_SEPOLIA_ENDPOINT, msg.sender);

        vm.stopBroadcast();
    }
}
