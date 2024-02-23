## Proxy Contract


**This contract acts as a proxy to delegate calls to other contracts based on function IDs. It allows for seamless upgradability of contract logic by updating the contract addresses associated with specific function IDs.**

### Functionality

-   **Mapping**: This contract maintains a mapping to store function IDs and their corresponding contract addresses.
-   **Event Emission**: An event is emitted whenever a contract address is updated in the registry.
-   **Ownership Control**: Only the owner of the contract has the authority to update contract addresses in the registry.
-   **Fallback Function**: Any call to this contract that does not match a specific function signature will be delegated to the appropriate contract based on the function ID.
-   **Implementation Update**: Functionality to update the contract address associated with a specific function ID.
-    **Implementation Retrieval**: Functionality to retrieve the contract address associated with a specific function ID.
-    **Ownership Transfer**: Functionality to transfer ownership of the contract.
-    **Ether Reception**: Ability to receive Ether transactions.

    
### Usage

**Constructor**
Upon deployment, the constructor sets the deployer's address as the owner of the contract.

**Fallback Function**
The fallback function delegates calls to the appropriate contract based on the function ID stored in the registry.

**updateImplementation**
This function is used by the owner to update the contract address associated with a specific function ID.

**getImplementation**
This function allows anyone to retrieve the contract address associated with a specific function ID.

**transferOwnership**
The owner can transfer ownership of the contract using this function.

**receive**
This function is used to receive Ether transactions.

### Modifiers

-  **onlyOwner**: Restricts access to functions that update the contract registry to only the owner.
  
### Events

-   **ImplementationUpdated**: Emitted when a contract address is updated in the registry.
  
### License

**This contract is licensed under the MIT License. See the LICENSE file for details.**


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
