
# NFTMarketPlace

NFTMarketPlace is Place  where people come and mint the nft and put it on sell and anyone can buy that nft.




## Features
-  function getListingPrice-This function gives the listing price. 
-  function createMarketItem:-This function Mint the NFT in MarketPlace and putting it for sale.
-  function createMarketSale:-This function help us where we can buy and sell NFT.
-  function fetchMarketItems:-Give list of  all unsold NFT



## Work Flow

# We need Two function to interact with the contract

-  function createMarketItem().
-  function createMarketSale().

 How to mint NFT in the contract ?
  -
  We have a function called createMarketItem(). With the help of this function we mint the NFT in MarketPlace and putting it for sale.

How to Buy or sell NFT which is already present in Market Palce ?
   -
   We have a function called createMarketSale(). With the help of this Function we can buy and sell NFT which is already present in Market Palce.

   



## Running Tests

To run tests, You have to go terminal and run the following command

```bash
  npx hardhat test
```


## Deployment

To deploy this project.You have to go in terminal and run these command

```bash
  npx hardhat run scripts/deploy.js --network mumbai
  
```