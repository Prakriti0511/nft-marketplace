// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721//extensions/ERC721URIStorage.sol";

contract NFTStore is ERC721URIStorage{
    address payable public marketplaceOwner;
    uint256 public listingFeePercent = 20;
    uint256 private currentTokenId;
    uint256 private totalItemsSold;

    struct NFTListing {
        uint256 tokenId;
        address payable owner;
        address payable seller;
        uint256 price;
    }

    mapping(uint256=> NFTListing) private tokenIdToListing;

    modifier onlyOwner {
        require(msg.sender == marketplaceOwner, "Only owner can call this function.");
        _;
    }
    constructor() ERC721("NFTSTORE", "NFTS"){
        marketplaceOwner = payable(msg.sender);
    }

    function updateListingFeePercent(uint256 _listingFeePercent) public onlyOwner{
        listingFeePercent = _listingFeePercent;
    }
    
    function getCurrentTokenId() public view returns(uint256){
        return currentTokenId;
    }

    function getNFTListing(uint256 _tokenId) public view returns(NFTLisitng memory){
        return tokenIdToListing[_tokenId];
    }

    function createToken(string memory _tokenURI, uint256 _price) public returns(uint256){
        require(_price>0, "Price must be greater than zero");

        currentTokenId++;
        uint256 newTokenId = currentTokenId;
        _safeMint(msg.sender, newTokenId); //already in openzeppelin
        _setTokenURI(newTokenId, _tokenURI);

        createNFTListing(newTokenId, _price);
        return newTokenId;
    }

    function createNFTListing(uint256 _tokenId, uint256 _price) private{
        tokenIdToListing[_tokenId] = NFTLisitng({
            tokenId : _tokenId,
            owner : payable(msg.sender),
            seller: payable(msg.sender),
            price: _price
        });
    }

    function executeSale(uint256 tokenId) public payable{
        NFTListing storage listing = tokenIdToListing[tokenId];
        uint256 price = listing.price;
        address payable seller = listing.seller;
        require(msg.value==price, "Please submit the asking price to complete the purchase");
    }
}