// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TeaVerseAvatars is ERC721Enumerable, Ownable {
    using Strings for uint256;

    uint256 public maxSupply = 100;
    string public baseURI;
    bool public paused = false;
    mapping(address => bool) public hasMinted;

    constructor(string memory _initBaseURI) ERC721("TeaVerse Avatars", "TEA") {
        baseURI = _initBaseURI;
    }

    function mint() public {
        require(!paused, "Minting is paused");
        require(totalSupply() < maxSupply, "Max supply reached");
        require(!hasMinted[msg.sender], "You have already minted");

        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);
        hasMinted[msg.sender] = true;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Nonexistent token");
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }
}
