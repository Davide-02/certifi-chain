// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CertiFi} from "../src/CertiFi.sol";

contract CertiFiTest is Test {
    CertiFi internal cert;

    function setUp() public {
        cert = new CertiFi();
    }

    function testStoreAndRetrieveHash() public {
        bytes32 expected = keccak256("identity-data");

        vm.prank(address(0xA11CE));
        cert.storeHash(expected);

        bytes32 stored = cert.getHash(address(0xA11CE));
        assertEq(stored, expected);
    }

    function testDifferentUsersIsolation() public {
        bytes32 hashAlice = keccak256("alice");
        bytes32 hashBob = keccak256("bob");

        vm.prank(address(0xA11CE));
        cert.storeHash(hashAlice);

        vm.prank(address(0xB0B));
        cert.storeHash(hashBob);

        assertEq(cert.getHash(address(0xA11CE)), hashAlice);
        assertEq(cert.getHash(address(0xB0B)), hashBob);
    }

    function testCannotStoreZeroHash() public {
        vm.prank(address(0xBAD));
        vm.expectRevert("CertiFi: empty hash");
        cert.storeHash(bytes32(0));
    }

    function testVerifyHash() public {
        bytes32 testHash = keccak256("test-identity");

        // Hash non esiste ancora
        assertFalse(cert.verify(testHash));

        // Salva l'hash
        vm.prank(address(0x123));
        cert.storeHash(testHash);

        // Ora l'hash esiste
        assertTrue(cert.verify(testHash));

        // Hash diverso non esiste
        bytes32 otherHash = keccak256("other-identity");
        assertFalse(cert.verify(otherHash));
    }
}
