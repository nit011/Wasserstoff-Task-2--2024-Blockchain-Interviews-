// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ProxyContract {
    // Mapping to store function IDs and corresponding contract addresses
    mapping(bytes4 => address) private implementationAddresses;

    // Event emitted when a contract address is updated in the registry
    event ImplementationUpdated(bytes4 indexed functionId, address indexed implementation);

    // Modifier to restrict access to the contract registry update functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this operation");
        _;
    }

    // Address of the owner of the contract
    address public owner;

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Fallback function to delegate calls to the appropriate contract
    fallback() external payable {
        // Get the contract address corresponding to the function ID
        address implementation = implementationAddresses[msg.sig];
        // Ensure the implementation address is valid
        require(implementation != address(0), "Function not implemented");
        
        // Delegate call to the implementation contract
        assembly {
            let ptr := mload(0x40) // Load free memory pointer
            calldatacopy(ptr, 0, calldatasize()) // Copy input data to free memory
            let result := delegatecall(gas(), implementation, ptr, calldatasize(), 0, 0) // Delegate call to implementation contract
            let size := returndatasize() // Get the size of the return data
            returndatacopy(ptr, 0, size) // Copy the return data to free memory
            
            switch result
            case 0 { revert(ptr, size) } // Revert if the call failed
            default { return(ptr, size) } // Return the result
        }
    }

    // Function to update the contract address for a given function ID
    function updateImplementation(bytes4 functionId, address newImplementation) external onlyOwner {
        // Update the contract address in the registry
        implementationAddresses[functionId] = newImplementation;
        // Emit an event indicating the update
        emit ImplementationUpdated(functionId, newImplementation);
    }

    // Function to retrieve the contract address for a given function ID
    function getImplementation(bytes4 functionId) external view returns (address) {
        // Return the contract address corresponding to the function ID
        return implementationAddresses[functionId];
    }

    // Function to transfer ownership of the contract
    function transferOwnership(address newOwner) external onlyOwner {
        // Ensure the new owner address is valid
        require(newOwner != address(0), "Invalid owner address");
        // Update the owner of the contract
        owner = newOwner;
    }

    // Receive function to receive Ether transactions
    receive() external payable {}
}
