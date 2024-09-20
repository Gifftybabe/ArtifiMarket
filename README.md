# MetaMintMarketplace

MetaMintMarketplace is a decentralized NFT marketplace where users can mint, list, buy, and sell NFTs. Built using Solidity and leveraging the ERC-721 standard, this platform allows users to easily trade digital assets on the Ethereum blockchain.

## Features

- **Mint NFTs**: Only the contract owner can mint new NFTs.
- **List NFTs for Sale**: NFT owners can list their tokens for sale at a specified price.
- **Buy NFTs**: Anyone can purchase NFTs that are listed for sale by sending the required Ether.
- **Remove Listings**: NFT owners can remove their tokens from sale.
- **Withdraw Funds**: The contract owner can withdraw the contract's balance.

## Tech Stack

- **Solidity**: Smart contract programming language.
- **Hardhat**: Ethereum development environment for compiling, deploying, testing, and debugging.
- **TypeScript**: Used for writing unit tests.
- **OpenZeppelin**: Secure and tested contracts, including the ERC-721 token standard and Ownable contract.

## Setup

### Prerequisites

- Node.js
- npm or yarn
- Hardhat
- TypeScript (for testing)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Gifftybabe/MetaMinter.git
   cd MetaMinter.git
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile the contracts:
   ```bash
   npx hardhat compile
   ```

4. Run tests:
   ```bash
   npx hardhat test
   ```

## Deployment

1. Update `hardhat.config.ts` with your preferred network and private key.
2. Deploy the contract:
   ```bash
   npx hardhat run scripts/deploy.ts --network <network-name>
   ```

## Usage

1. **Minting an NFT**: Only the owner of the contract can mint new NFTs.
2. **Listing for Sale**: After minting, the owner of an NFT can list it for sale by specifying a price in wei.
3. **Buying an NFT**: Anyone can purchase a listed NFT by sending the required Ether.
4. **Withdrawing Funds**: The contract owner can withdraw accumulated funds from NFT sales.

## Contract Overview

- **MetaMintMarketplace.sol**: The core contract where minting, listing, and buying NFTs take place.
- **Test**: Contains TypeScript-based tests for contract functionality.

