// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint256} from "lib/fhenix-contracts/contracts/FHE.sol";

contract Bidder {
    inEuint256 public encryptedBid;

    function setBid(inEuint256 calldata newEncryptedBid) external {
        encryptedBid = newEncryptedBid;

        // TODO: send encryptedBid to Auction on Fhenix via LayerZero
    }
}
