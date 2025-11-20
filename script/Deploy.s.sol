// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {CertiFi} from "../src/CertiFi.sol";

contract DeployCertiFi is Script {
    function run() external returns (CertiFi) {
        vm.startBroadcast();
        CertiFi cert = new CertiFi();
        vm.stopBroadcast();
        return cert;
    }
}
