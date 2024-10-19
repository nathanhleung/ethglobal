// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint256} from "lib/fhenix-contracts/contracts/FHE.sol";

contract Auction {
    inEuint256 public encryptedHighestBid;

    function receiveEncryptedBid(inEuint256 calldata encryptedBid) external {
    }

    // TODO: once auction ends on Fhenix, transfer funds on other chain from bidder
}
