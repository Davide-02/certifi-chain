// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract CertiFi is ERC721, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => string) private tokenURIs;

    constructor() ERC721("CertiFiAttestation", "CERT") Ownable(msg.sender) {}

    function mint(address to, string memory metadataURI)
        external
        onlyOwner
    {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        tokenURIs[tokenId] = metadataURI;
    }

    function tokenURI(uint256 id)
        public
        view
        override
        returns (string memory)
    {
        return tokenURIs[id];
    }
}