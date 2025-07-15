// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract HeroesNft is ERC721{
    string private s_supermanSvgImageUri;
    string private s_batmanSvgImageUri;
    string private s_flashSvgImageUri; 
    uint256 private s_tokenCounter;

    error MoodNft__CantFlipMoodIfNotOwner();

    enum Heroes {
        SUPERMAN,
        BATMAN,
        FLASH
    }
    
    mapping (uint256 => Heroes) s_tokenIdToHeroes;

    constructor (
        string memory supermanSvgImageUri,
        string memory batmanSvgImageUri,
        string memory flashSvgImageUri
    )ERC721("Heroes NFT","HNT"){
        s_supermanSvgImageUri = supermanSvgImageUri;
        s_batmanSvgImageUri = batmanSvgImageUri;
        s_flashSvgImageUri = flashSvgImageUri;
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender , s_tokenCounter);
        s_tokenIdToHeroes[s_tokenCounter] = Heroes.SUPERMAN;
        s_tokenCounter++;
    }

    function flipHeroes(uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        if(!_isAuthorized(owner,msg.sender,tokenId)){
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if(s_tokenIdToHeroes[tokenId] == Heroes.SUPERMAN){
            s_tokenIdToHeroes[tokenId]=Heroes.BATMAN;
        }
        else if(s_tokenIdToHeroes[tokenId] == Heroes.BATMAN){
            s_tokenIdToHeroes[tokenId] = Heroes.FLASH;
        }
        else{
            s_tokenIdToHeroes[tokenId] = Heroes.SUPERMAN;
        }
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64;";
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        string memory imageURI;

        if(s_tokenIdToHeroes[tokenId] == Heroes.SUPERMAN){
            imageURI = s_supermanSvgImageUri;
        }
        else if(s_tokenIdToHeroes[tokenId] == Heroes.BATMAN){
            imageURI = s_batmanSvgImageUri;
        }
        else{
            imageURI = s_flashSvgImageUri;
        }

        return string(
            abi.encodePacked(
            _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"', name(), '", "description":"An Nft that selects between Several Justice league members.", "attributes": [{"trait_type":"moodiness", "value" :100}], "image": "', imageURI, '"}'
                        )
                    )
                )
            )
        );
    }
}