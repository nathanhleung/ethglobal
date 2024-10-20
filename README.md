# Omnichain Secret Auctions

Using fully-homomorphic encryption on Fhenix to implement second-price sealed bid auctions, and using LayerZero to allow bids from any chain, unifying liquidity: a global secret auction across all chains.

## User Flow
1. Auction creator creates an auction contract on Fhenix.
    1. The auction creator sets an auction start / end date, minimum bid, and code to run when the auction is won (e.g. automatically send an NFT). This code can be run cross-chain using LayerZero.
1. User visits our frontend, they want to bid on X Chain
1. We use Fhenix’s FHE frontend library to encrypt their bid.
1. Encrypted bid is sent to our bid submission smart contract on X Chain.
    1. We also ask the user to approve the bid submission smart contract as a spender for UINT256_MAX
1. We use LayerZero to send the encrypted bid to our auction smart contract on Fhenix.
    1. The auction contract stores the encrypted bit and the chain from which the bid originated.
    1. Since it’s difficult to install on LayerZero on new chains, we’re actually sending via Sepolia (the base cain for the Fhenix L2)
1. At the end of the auction period, the contract uses FHE to compare all bids and determine which bid is the highest
1. We use LayerZero to send a message back to the chain from which the bid originated and transfer the assets from the winning bidder.
    1. If the transfer is unsuccessful, LayerZero can send message back and Fhenix contract can move on to next highest bidder

## Components
1. Frontend which can grab data from Fhenix to show auction status and can send data to X Chain to submit bids
    1. Figure out how encrypt data with the Fhenix JS SDK and send it as arbitrary bytes to another smart contract
1. Auction smart contract on Fhenix
    1. Figure out how to compare different encrypted values on Fhenix
1. Bid submission contract on any L1 we want to support
    1. Figure out how to accept encrypted bytes
1. LayerZero infrastructure to send data to and from other L1s and Fhenix
    1. Figure out how to send data between chains
