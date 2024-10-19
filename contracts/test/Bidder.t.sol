// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {inEuint256} from "lib/fhenix-contracts/contracts/FHE.sol";
import {Bidder} from "../src/Bidder.sol";

contract BidderTest is Test {
    Bidder public bidder;

    function setUp() public {
        bidder = new Bidder();
    }

    function test_Increment() public {
        inEuint256 memory encryptedBid = inEuint256(bytes("hello"), 100);
        bidder.setBid(encryptedBid);
        (bytes memory data, int32 securityZone) = bidder.encryptedBid();
        assertEq(data, encryptedBid.data);
        assertEq(securityZone, encryptedBid.securityZone);
    }
}
