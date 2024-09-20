// test/MetaMintMarketplaceTest.ts
import { expect } from "chai";
import { ethers } from "hardhat";
import { MetaMintMarketplace, MetaMintMarketplace__factory } from "../typechain-types";

describe("MetaMintMarketplace", function () {
  let marketplace: MetaMintMarketplace;
  let owner: any;
  let addr1: any;
  let addr2: any;

  beforeEach(async function () {
    // Deploy the contract
    const MetaMintMarketplaceFactory: MetaMintMarketplace__factory = await ethers.getContractFactory("MetaMintMarketplace");
    [owner, addr1, addr2] = await ethers.getSigners();
    marketplace = await MetaMintMarketplaceFactory.deploy();
  });

  it("should allow the owner to mint an NFT", async function () {
    await marketplace.mintNFT(addr1.address); // Mint to addr1

    expect(await marketplace.ownerOf(1)).to.equal(addr1.address);
    expect(await marketplace.nextNFTId()).to.equal(2); // nextNFTId should be incremented
  });

  it("should allow an NFT owner to list their NFT for sale", async function () {
    await marketplace.mintNFT(addr1.address); // Mint to addr1

    // Connect to addr1 and list the NFT for sale
    await marketplace.connect(addr1).listNFTForSale(1, ethers.parseEther("1"));

    const listing = await marketplace.nftListings(1);
    expect(listing.seller).to.equal(addr1.address);
    expect(listing.price).to.equal(ethers.parseEther("1"));
    expect(listing.isAvailable).to.be.true;
  });

  it("should allow another user to buy a listed NFT", async function () {
    await marketplace.mintNFT(addr1.address); // Mint to addr1

    // List the NFT for sale by addr1
    await marketplace.connect(addr1).listNFTForSale(1, ethers.parseEther("1"));

    // addr2 buys the NFT
    await marketplace.connect(addr2).purchaseNFT(1, { value: ethers.parseEther("1") });

    expect(await marketplace.ownerOf(1)).to.equal(addr2.address); // Ownership should be transferred
    const listing = await marketplace.nftListings(1);
    expect(listing.isAvailable).to.be.false; // NFT should no longer be for sale
  });

  it("should allow the NFT owner to remove a listing", async function () {
    await marketplace.mintNFT(addr1.address); // Mint to addr1

    // List the NFT for sale by addr1
    await marketplace.connect(addr1).listNFTForSale(1, ethers.parseEther("1"));

    // Remove the listing
    await marketplace.connect(addr1).delistNFT(1);

    const listing = await marketplace.nftListings(1);
    expect(listing.isAvailable).to.be.false; // Listing should no longer be available
  });

  it("should allow the contract owner to withdraw funds", async function () {
    await marketplace.mintNFT(addr1.address); // Mint to addr1
    await marketplace.connect(addr1).listNFTForSale(1, ethers.parseEther("1"));

    // addr2 buys the NFT
    await marketplace.connect(addr2).purchaseNFT(1, { value: ethers.parseEther("1") });

    // Contract balance should be 1 ether now
    const contractBalance = await ethers.provider.getBalance(marketplace);
    expect(contractBalance).to.equal(ethers.parseEther("1"));

    // Owner withdraws funds
    await marketplace.withdrawFunds();

    const updatedContractBalance = await ethers.provider.getBalance(marketplace);
    expect(updatedContractBalance).to.equal(0);
  });
});
