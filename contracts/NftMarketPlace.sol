// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MetaMintMarketplace is ERC721, Ownable(msg.sender) {
    uint256 public nextNFTId;

    struct NFTListing {
        address seller;
        uint256 price;
        bool isAvailable;
    }

  
    mapping(uint256 => NFTListing) public nftListings;

    constructor() ERC721("MetaMintMarketplace", "MMM") {
        nextNFTId = 1; 
    }

 
    function mintNFT(address to) external onlyOwner {
        uint256 nftId = nextNFTId; 
        nextNFTId++; 
        _safeMint(to, nftId);
    }

 
    function listNFTForSale(uint256 nftId, uint256 price) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(price > 0, "Price must be greater than 0");

        nftListings[nftId] = NFTListing({
            seller: msg.sender,
            price: price,
            isAvailable: true
        });
    }

  
    function purchaseNFT(uint256 nftId) external payable {
        NFTListing memory listedNFT = nftListings[nftId];

        require(listedNFT.isAvailable, "NFT not for sale");
        require(msg.value >= listedNFT.price, "Insufficient funds");

   
        _transfer(listedNFT.seller, msg.sender, nftId);

      
        nftListings[nftId].isAvailable = false;

        payable(listedNFT.seller).transfer(msg.value);
    }

   
    function delistNFT(uint256 nftId) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(nftListings[nftId].isAvailable, "NFT is not listed for sale");

        delete nftListings[nftId];
    }

   
    function updateNFTPrice(uint256 nftId, uint256 newPrice) external {
        require(ownerOf(nftId) == msg.sender, "Not the NFT owner");
        require(nftListings[nftId].isAvailable, "NFT not listed for sale");
        require(newPrice > 0, "Price must be greater than 0");

        nftListings[nftId].price = newPrice;
    }

 
    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
