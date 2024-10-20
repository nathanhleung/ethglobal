// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint128} from "lib/fhenix-contracts/contracts/FHE.sol";
import {OApp, Origin, MessagingFee} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OApp.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OptionsBuilder} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/libs/OptionsBuilder.sol";

/// @notice This contract relays bids from Sepolia to the Auction on Fhenix Helium.
contract RelayBid is OApp {
    using OptionsBuilder for bytes;

    /// @param _endpoint The address of the local LayerZero endpoint.
    /// @param _owner The address of the owner of the contract.
    constructor(address _endpoint, address _owner) OApp(_endpoint, _owner) Ownable(_owner) {}

    function relayBid(inEuint128 calldata newEncryptedBid) external {
        encryptedBid = newEncryptedBid;

        // TODO: send encryptedBid to Auction on Fhenix via Arb Nitro bridge
    }
}
