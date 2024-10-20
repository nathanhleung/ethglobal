// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint128, ebool, euint128, FHE} from "lib/fhenix-contracts/contracts/FHE.sol";

contract FHEEcho {
    function echo(inEuint128 calldata encryptedInput) public view returns(uint128) {
      return FHE.decrypt(FHE.asEuint128(encryptedInput));
    }
}