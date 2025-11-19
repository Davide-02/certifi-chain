// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/CertiFi.sol";

contract MintCertiFi is Script {
    function run() external {
        address contractAddress = vm.envAddress("CERTIFI_CONTRACT");
        address recipient = vm.envAddress("RECIPIENT");
        string memory uri = vm.envString("TOKEN_URI");

        vm.startBroadcast();
        CertiFi(contractAddress).mint(recipient, uri);
        vm.stopBroadcast();
    }
}