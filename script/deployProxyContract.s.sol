// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {ProxyContract} from "../src/Proxy Contract.sol";
//import {HelperConfig} from "./Helper-config.s.sol";

contract DeployProxyContract is Script{
    function run() external  {
    //HelperConfig helperConfig = new HelperConfig();
      //returns (ProxyContract, HelperConfig)
        vm.startBroadcast();
        new ProxyContract();
        vm.stopBroadcast();
        
    }
}
