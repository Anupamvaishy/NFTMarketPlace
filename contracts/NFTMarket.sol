// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//This is a security mechanism thats is going tp give us utility called non-Reentrant.Kind of a security control that prevent re-entry Attacks.
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarket is ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds; //This is for each individual Market item that's created
    Counters.Counter private _itemsSold; //This counter for number of items sold.
    address payable owner; //To determine who is the owner of this contract.
    uint256 listingPrice = 0.025 ether; //Set the listing price.

    /*This constructor is saying that the owner of the contract is the person who is deploying that contract.*/
    constructor() {
        owner = payable(msg.sender);
    }

    struct MarketItem {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    /*this mapping map itemId as key and marketItem as value.*/
    mapping(uint256 => MarketItem) private idToMarketItem;

    event MarketItemCreated(uint256 indexed itemId, address indexed nftContract, uint256 indexed tokenId, address seller, address owner, uint256 price, bool sold);
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    /*This function is for creating a market item and putting is on sell.*/
    function createMarketItem(address nftContract, uint256 tokenId, uint256 price ) public payable nonReentrant {
        require(price > 0, "Price must be at least 1 wei");
        require(msg.value == listingPrice, "price mustbe equal to listing price" );
        _itemIds.increment(); //Increment Item Ids
        uint256 itemId = _itemIds.current(); //created a varible called "itemId" this id is for item which is going for sell right now
        idToMarketItem[itemId] = MarketItem(itemId, nftContract, tokenId, payable(msg.sender), payable(address(0)), price, false );

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId); //This is line Tranfer owner of the NFT to contract itself.

        emit MarketItemCreated( itemId, nftContract, tokenId, msg.sender, address(0), price, false);
    }

    /*This function Market sell.*/
    function createMarketSale(address nftContract, uint256 itemId) public payable nonReentrant {
        uint256 price = idToMarketItem[itemId].price; //this line give price of item which is in market item using mapping.
        uint256 tokenId = idToMarketItem[itemId].tokenId; //this line give tokenId of item which is in market item using mapping.
        require(msg.value == price,"Please submit the asking price in order to complete the purchase" );
        idToMarketItem[itemId].seller.transfer(msg.value); //Tranfer the money to the seller.
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId); //sent NFT to the buyer.
        idToMarketItem[itemId].sold = true; //updating the value in the map.
        _itemsSold.increment();
        payable(owner).transfer(listingPrice); //Transfer the listing price to the owner of contract.
    }

    /* Returns all unsold items */
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _itemIds.current(); //itemCount variable store itemId of current item.
        uint256 unsoldItemCount = _itemIds.current() - _itemsSold.current(); //This line store number of item which is unsold in variable name unsoldItemCount.
        uint256 currentIndex = 0;
        /*Create an empty array which store marketItem*/
        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            /**Check if this item is unsold or not */
            if (idToMarketItem[i + 1].owner == address(this)) {
                uint256 currentId = idToMarketItem[i + 1].itemId; //currentId of a item which interacting right now
                MarketItem storage currentItem = idToMarketItem[currentId]; //Create a value called currentItem that's going to go and get the mapping of the idToMarketItem passing in the current id
                items[currentIndex] = currentItem; //Insert that item into an array
                currentIndex += 1; //Increment currentItem
            }
        }
        return items;
    }
}
