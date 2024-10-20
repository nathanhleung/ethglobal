# Contracts

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

1. First, deploy the `Bidder` contract on chains which should receive bids.
1. Then, deploy `RelayBid` contract on Sepolia. Make sure to call `setPeer` for every chain which `Bidder` is deployed on.
1. Finally, deploy `Auction` on Fhenix Helium.

```shell
$ forge script script/Bidder.s.sol:BidderScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```