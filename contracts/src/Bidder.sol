// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint8} from "lib/fhenix-contracts/contracts/FHE.sol";
import {OApp, Origin, MessagingFee} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OApp.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OptionsBuilder} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/libs/OptionsBuilder.sol";

/// @notice This contract takes bids from any chain, and sends them to the RelayBid contract on Sepolia using LayerZero.
contract Bidder is OApp {
    using OptionsBuilder for bytes;

    event ReceivedData(string data);

    uint32 public constant RELAY_BID_EID = 	40161; // Sepolia

    /// @param _endpoint The address of the local LayerZero endpoint.
    /// @param _owner The address of the owner of the contract.
    constructor(address _endpoint, address _owner) OApp(_endpoint, _owner) Ownable(_owner) {}

    function hello() external payable {
        emit ReceivedData("hello!");
    }

    function sendBid(inEuint8 calldata encryptedBid) external payable {
        bytes memory _payload = abi.encode(msg.sender, block.chainid, encryptedBid);
        bytes memory _options = OptionsBuilder
            .newOptions()
            // gas and value for the executor on the destination chain
            .addExecutorLzReceiveOption(200000, 0);

        // Send bid to Sepolia
        _lzSend(
            RELAY_BID_EID,
            _payload,
            _options,
            // Fee in native gas and ZRO token.
            MessagingFee(msg.value, 0),
            // Refund address in case of failed source message.
            payable(msg.sender)
        );
    }

    /**
     * @dev Called when data is received from the protocol. It overrides the equivalent function in the parent contract.
     * Protocol messages are defined as packets, comprised of the following parameters.
     * @param _origin A struct containing information about where the packet came from.
     * @param _guid A global unique identifier for tracking the packet.
     * @param payload Encoded message.
     */
    function _lzReceive(
        Origin calldata _origin,
        bytes32 _guid,
        bytes calldata payload,
        address, // Executor address as specified by the OApp.
        bytes calldata // Any extra data or options to trigger on receipt.
    ) internal override {
        // Decode the payload to get the message
        // In this case, type is string, but depends on your encoding!
        string memory data = abi.decode(payload, (string));
        emit ReceivedData(data);
    }
}
