// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaMintMarketplace is ERC721, Ownable {
    uint256 public nextNFTId;

    struct NFTListing {
        address seller;
        uint256 price;
        bool isAvailable;
    }

    // Mapping from NFT ID to its listing details
    mapping(uint256 => NFTListing) public nftListings;

    constructor() ERC721("MetaMintMarketplace", "MMM") {
        nextNFTId = 1; // Initialize token ID to 1
    }

    /**
     * @dev Mint new NFTs. Only contract owner can mint.
     * @param to Address of the receiver of the minted NFT.
     */
    function mintNFT(address to) external onlyOwner {
        uint256 nftId = nextNFTId; // Assign current NFT ID
        nextNFTId++; // Increment NFT ID for next mint

        _safeMint(to, nftId);
    }

    /**
     * @dev List an NFT for sale. Only the owner of the token can list it.
     * @param nftId ID of the token to list for sale.
     * @param price Sale price in wei.
     */
    function listNFTForSale(uint256 nftId, uint256 price) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(price > 0, "Price must be greater than 0");

        nftListings[nftId] = NFTListing({
            seller: msg.sender,
            price: price,
            isAvailable: true
        });
    }

    /**
     * @dev Buy an NFT that is listed for sale. Buyer sends ETH equivalent to the price.
     * @param nftId ID of the token to buy.
     */
    function purchaseNFT(uint256 nftId) external payable {
        NFTListing memory listedNFT = nftListings[nftId];

        require(listedNFT.isAvailable, "NFT not for sale");
        require(msg.value >= listedNFT.price, "Insufficient funds");

        // Transfer ownership of the NFT
        _transfer(listedNFT.seller, msg.sender, nftId);

        // Mark as no longer for sale
        nftListings[nftId].isAvailable = false;

        // Transfer the sale price to the seller
        payable(listedNFT.seller).transfer(msg.value);
    }

    /**
     * @dev Remove an NFT from being listed for sale. Only the owner can remove the listing.
     * @param nftId ID of the token to remove from sale.
     */
    function delistNFT(uint256 nftId) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(nftListings[nftId].isAvailable, "NFT is not listed for sale");

        delete nftListings[nftId];
    }

    /**
     * @dev Change the price of an NFT that is already listed for sale. Only the seller can update.
     * @param nftId ID of the token to update price.
     * @param newPrice The new sale price in wei.
     */
    function updateNFTPrice(uint256 nftId, uint256 newPrice) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(nftListings[nftId].isAvailable, "NFT not listed for sale");
        require(newPrice > 0, "Price must be greater than 0");

        nftListings[nftId].price = newPrice;
    }

    /**
     * @dev Withdraw contract's balance. Only the owner of the contract can withdraw.
     */
    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
