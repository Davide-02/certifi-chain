// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CertiFi.sol";

contract CertiFiTest is Test {
    CertiFi cert;

    function setUp() public {
        cert = new CertiFi();
    }

    function testMint() public {
        cert.mint(address(0x1234), "ipfs://test.json");
        assertEq(cert.tokenURI(0), "ipfs://test.json");
    }
}