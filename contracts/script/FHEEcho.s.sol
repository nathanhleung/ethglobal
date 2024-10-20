// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {FHEEcho} from "../src/FHEEcho.sol";

contract FHEEchoScript is Script {
    FHEEcho public fheEcho;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        fheEcho = new FHEEcho();

        vm.stopBroadcast();
    }
}
