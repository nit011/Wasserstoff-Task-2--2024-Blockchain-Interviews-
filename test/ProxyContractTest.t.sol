// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {ProxyContract} from "../src/Proxy Contract.sol";


contract ProxyContractTest is Test {
    // Deployed instance of the proxy contract
    ProxyContract proxyContract;
    // Deployed instance of the mock implementation contract
    MockImplementation mockImplementation;

    // Deploy the proxy contract and mock implementation contract before each test
    function beforeEach() public {
        proxyContract = new ProxyContract();
        mockImplementation = new MockImplementation();
    }

    // Test updating implementation address
    function testUpdateImplementation() public {
        // Update the implementation address in the proxy contract
        proxyContract.updateImplementation(bytes4(keccak256("testFunction()")), address(mockImplementation));
        // Verify that the implementation address was updated successfully
        assertEq(proxyContract.getImplementation(bytes4(keccak256("testFunction()"))), address(mockImplementation));
    }

    // Test delegation of function call
    function testDelegation() public {
        // Update the implementation address in the proxy contract
        proxyContract.updateImplementation(bytes4(keccak256("testFunction()")), address(mockImplementation));
        // Call the proxy contract function that should be delegated to the implementation contract
        (bool success, ) = address(proxyContract).call(abi.encodeWithSignature("testFunction()"));
        // Verify that the function was called in the implementation contract
        assertTrue(success);
        assertTrue(mockImplementation.functionCalled());
    }
}

// Mock implementation contract
contract MockImplementation {
    bool public functionCalled;

    // Function to test delegation
    function testFunction() external {
        functionCalled = true;
    }
}