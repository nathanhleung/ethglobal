// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {inEuint128, ebool, euint128, FHE} from "lib/fhenix-contracts/contracts/FHE.sol";
import {ArbSys} from "./ArbSys.sol";

struct Bid {
  euint128 ebid;
  address from;
  uint256 chainId;
}

event ASE(uint128 bid, address from, address to, uint256 chainId, address token);
event NewAuction(uint256 id);

contract Auction {
    mapping(uint256 => uint256) public endTime;
    uint256 public auctionId = 0;
    mapping(uint256 => address) public dstAddr;
    mapping(uint256 => Bid[]) public bids;
    mapping(uint256 => bool) public finalized;
    mapping(uint256 => uint256) public minBids;
    mapping(uint256 => mapping(uint256 => address)) tokenList;

    function startAuction(uint256 minBid, address dst, uint256 durationSeconds, uint256[] calldata chainIdList, address[] calldata tokenAddrList) external {
      endTime[auctionId] = block.timestamp + durationSeconds;
      minBids[auctionId] = minBid;
      dstAddr[auctionId] = dst;
      require(chainIdList.length == tokenAddrList.length);
      for (uint256 i = 0; i < chainIdList.length; i++) {
        tokenList[auctionId][chainIdList[i]] = tokenAddrList[i];
      }
      emit NewAuction(auctionId);
      auctionId += 1;
    }
    // TODO: make this function permissioned
    function receiveEncryptedBid(uint256 id, inEuint128 calldata encryptedBid, address from, uint256 chainId) external {
      require (tokenList[id][chainId] != address(0));
      require (id < auctionId);
      require (block.timestamp <= endTime[id]);
      euint128 bid = FHE.asEuint128(encryptedBid);
      require (FHE.decrypt(bid.gt(FHE.asEuint128(minBids[id]))));
      bids[id].push(Bid(bid, from, chainId));
    }
    function finalizeAuction(uint256 id) public {
      require (id < auctionId);
      require (block.timestamp > endTime[id]);
      require (!finalized[id]);
      euint128 maxBid = FHE.asEuint128(0);
      euint128 maxIdx = FHE.asEuint128(0);
      bool once = false;
      for (uint256 i = 0; i < bids[id].length; i++) {
        Bid memory bid = bids[id][i];
        if (bid.chainId == 0)
          continue;
        once = true;
        ebool cond = bid.ebid.gt(maxBid);
        maxBid = FHE.select(cond, bid.ebid, maxBid);
        maxIdx = FHE.select(cond, FHE.asEuint128(i), maxIdx);
      }
      uint256 dIdx = FHE.decrypt(maxIdx);
      if (once) {
        uint256 chainId = bids[id][dIdx].chainId;
        sendAuctionOutbound(FHE.decrypt(maxBid), bids[id][dIdx].from, dstAddr[id], chainId, tokenList[id][chainId]);
        bids[id][dIdx].chainId = 0;
      }
      finalized[id] = true;
    }
    function sendAuctionOutbound(uint128 bid, address from, address to, uint256 chainId, address token) internal {
      emit ASE(bid, from, to, chainId, token);
      // ArbSys(address(0x0000000000000000000000000000000000000064)).sendTxToL1(dest, data);
    }
    // TODO: make this function permissioned
    function failedToFinalizeAuction(uint256 id) external {
      require(finalized[id]);
      finalized[id] = false;
      finalizeAuction(id);
    }
}