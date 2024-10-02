# NFT Marketplace on Lisk

## Overview

This project implements a simple NFT (Non-Fungible Token) marketplace smart contract deployed on the Lisk blockchain. The contract allows users to mint, list, buy, and manage NFTs in a decentralized manner.

## Deployment

The NFT Marketplace contract is deployed on the Lisk blockchain at:

```
0x3dfe97cabC0F38299E75C87b822aA66Ce2B407Dc
```

## Features

- Mint NFTs (owner only)
- List NFTs for sale
- Buy listed NFTs
- Remove NFT listings
- Update listing prices
- Withdraw contract balance (owner only)
- Transfer contract ownership

## Contract Details

- Name: NFTMarketplace
- Symbol: NFTM
- Solidity Version: ^0.8.26
- Base: ERC721 (OpenZeppelin)

## Why Deploy on Lisk?

Lisk offers several advantages for smart contract deployment:

1. **Interoperability**: Seamless cross-chain communication and asset transfers.
2. **Scalability**: Sidechain architecture for improved performance.
3. **Developer-Friendly**: Comprehensive tooling and SDKs for easier development.
4. **Energy Efficiency**: Delegated Proof of Stake (DPoS) consensus mechanism.
5. **Cost-Effective**: Faster and cheaper transactions compared to many networks.
6. **Growing Ecosystem**: Opportunities in an expanding network of dApps.

## Getting Started

To interact with the contract:
1. Connect to the Lisk network
2. Use web3 libraries or Lisk's SDKs
3. Reference the contract address provided above

## Security Note

While this contract implements basic functionality, additional security measures may be necessary for production use. Conduct thorough testing and consider professional audits before deploying contracts with real value.

## Contributing

Contributions are welcome. Please submit pull requests or open issues to discuss potential improvements.

## License

This project is licensed under the MIT License.