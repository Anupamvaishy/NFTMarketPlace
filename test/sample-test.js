const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarket", function() {
    it("Should create and excute market sales", async function() {
        /* deploy the marketplace */
        const Market = await ethers.getContractFactory("NFTMarket");
        const market = await Market.deploy();
        await market.deployed();
        const marketAddress = market.address;

        const NFT = await ethers.getContractFactory("NFT");
        const nft = await NFT.deploy(marketAddress);
        await nft.deployed();
        const nftContractAddress = nft.address;

        let listingPrice = await market.getListingPrice();
        listingPrice = listingPrice.toString();

        const auctionPrice = ethers.utils.parseUnits("1", "ether");

        /* create two tokens */
        await nft.createToken("https://www.mytokenlocation.com");
        await nft.createToken("https://www.mytokenlocation2.com");

        await market.createMarketItem(nftContractAddress, 1, auctionPrice, {
            value: listingPrice,
        });
        await market.createMarketItem(nftContractAddress, 2, auctionPrice, {
            value: listingPrice,
        });

        const [_, buyerAddress] = await ethers.getSigners();

        /* execute sale of token to another user */
        await market
            .connect(buyerAddress)
            .createMarketSale(nftContractAddress, 1, { value: auctionPrice });

        const items = await market.fetchMarketItems();
        console.log("items:", items);
    });
});