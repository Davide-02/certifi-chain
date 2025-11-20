// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {CertiFi} from "../src/CertiFi.sol";

/// @notice Script per salvare un hash on-chain richiamando storeHash
contract StoreHashCertiFi is Script {
    function run() external {
        address contractAddress = vm.envAddress("CERTIFI_CONTRACT");
        bytes32 identityHash = vm.envBytes32("IDENTITY_HASH");

        vm.startBroadcast();
        CertiFi(contractAddress).storeHash(identityHash);
        vm.stopBroadcast();
    }
}
