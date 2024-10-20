// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Bidder} from "../src/Bidder.sol";

contract BidderScript is Script {
    Bidder public bidder;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Polygon Amoy, Arbitrum Sepolia
        address LAYERZERO_LOCAL_ENDPOINT = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        bidder = new Bidder{salt: "yerr!"}(LAYERZERO_LOCAL_ENDPOINT, msg.sender);
        console.log(address(bidder));

        uint32 SEPOLIA_EID = 40161;
        address SEPOLIA_RELAYBID_CONTRACT_ADDRESS = 0x5bC9bc4e13E6e747eFd6C250298a6C555F03d3DC;
        bidder.setPeer(SEPOLIA_EID, bytes32(bytes20(uint160(SEPOLIA_RELAYBID_CONTRACT_ADDRESS))));

        vm.stopBroadcast();
    }
}
