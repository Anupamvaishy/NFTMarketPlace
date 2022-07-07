// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter; //Its allow to continue incrementing
    Counters.Counter private _tokenIds; //TokenId is going to allows us to keep up with the incrementing value for the unique identifier for each token.
    address contractAddress; //This contractAddress store the address of marketplace

    constructor(address marketplaceAddress) ERC721("Metaverse Token", "METT") {
        contractAddress = marketplaceAddress;
    }

    //This function is for the minting new token.
    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment(); //Increment the vslue of token id.
        uint256 newItemId = _tokenIds.current(); //This variable newItemId store the vslue of new token id
        _mint(msg.sender, newItemId); //Mint the token with that function in which we have to pass two arguments
        _setTokenURI(newItemId, tokenURI); //This function is available in ERC721URIStorage.
        setApprovalForAll(contractAddress, true); //This function going to give the marketplace the approval to transact this token with user.
        return newItemId;
    }
}
