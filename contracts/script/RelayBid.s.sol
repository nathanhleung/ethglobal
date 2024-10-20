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

        uint32 POLYGON_AMOY_EID = 40267;
        address POLYGON_AMOY_BIDDER_CONTRACT_ADDRESS = 0xe1834A8294534B487B9A29F08ee1143428BFbfA1; // TODO: update this

        uint32 ARB_SEPOLIA_EID = 40231;
        address ARB_SEPOLIA_BIDDER_CONTRACT_ADDRESS = 0x65033E9ca2DF831e1e2718ae2047060064a2F3b3; // TODO: update this

        relayBid.setPeer(ARB_SEPOLIA_EID, bytes32(bytes20(uint160(ARB_SEPOLIA_BIDDER_CONTRACT_ADDRESS))));

        vm.stopBroadcast();
    }
}
