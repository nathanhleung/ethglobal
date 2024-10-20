// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {inEuint256} from "lib/fhenix-contracts/contracts/FHE.sol";
import {Bidder} from "../src/Bidder.sol";

contract BidderTest is Test {
    Bidder public bidder;

    function setUp() public {
    }

    function test_Increment() public {
    }
}
