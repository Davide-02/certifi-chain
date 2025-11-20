// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title CertiFi
/// @notice Contratto minimale per memorizzare hash associati a identità on-chain
contract CertiFi {
    /// @dev mapping tra indirizzo utente e hash memorizzato
    mapping(address => bytes32) private hashes;

    event HashStored(address indexed user, bytes32 hashValue);

    /// @notice Memorizza l'hash dell'utente chiamante
    /// @param hashValue Hash (già calcolato off-chain) da salvare
    function storeHash(bytes32 hashValue) external {
        require(hashValue != bytes32(0), "CertiFi: empty hash");
        hashes[msg.sender] = hashValue;
        emit HashStored(msg.sender, hashValue);
    }

    /// @notice Restituisce l'hash associato a un utente
    /// @param user Indirizzo dell'utente
    /// @return hashValue Hash memorizzato (bytes32)
    function getHash(address user) external view returns (bytes32 hashValue) {
        return hashes[user];
    }
}