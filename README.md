
# SupermarketLoyaltyPoints Smart Contract

## Description

The `SupermarketLoyaltyPoints` smart contract is an ERC20 token designed to manage a supermarket's loyalty points system. This contract allows for the minting, burning, and transferring of loyalty points. It demonstrates fundamental ERC20 token functions and incorporates access control to ensure that only the contract owner can mint tokens. Additionally, it tracks customer registrations to ensure that only registered customers can receive loyalty points.

## Getting Started

### Prerequisites

To deploy and interact with this contract, you will need:

1. **Development Environment**:
   - A development environment like Remix IDE, or a local setup using tools such as Hardhat or Truffle.
   
2. **Ethereum Network**:
   - A browser extension like MetaMask for interacting with the Ethereum network.

### Installing

1. **Open Remix IDE**:
   - Navigate to [Remix IDE](https://remix.ethereum.org/).
   - Create a new file in Remix and paste the contract code provided below.

2. **Install Dependencies**:
   - **Remix IDE**: The contract imports OpenZeppelin's ERC20 and Ownable contracts, which are available in Remix by default. No additional setup is required.
   

### Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SupermarketLoyaltyPoints is ERC20, Ownable {

    struct Customer {
        bool registered;
    }

    mapping(address => Customer) public customers;

    constructor() ERC20("SupermarketLoyaltyPoints", "SLP") Ownable(msg.sender) {}

    function registerCustomer(address customer) public {
        require(!customers[customer].registered, "Customer is already registered");
        customers[customer].registered = true;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(customers[to].registered, "Customer is not registered");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public {
        require(amount <= balanceOf(from), "Insufficient balance to burn");
        _burn(from, amount);
    }

    function transferPoints(address to, uint256 amount) public {
        transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        return super.transferFrom(from, to, amount);
    }
}
```

### Executing Program

Follow these steps to deploy and interact with the contract:

1. **Compile the Contract**:
   - In Remix IDE, select the appropriate Solidity compiler version (0.8.20 or higher).
   - Compile the contract by clicking the "Compile" button.

2. **Deploy the Contract**:
   - Go to the "Deploy & Run Transactions" tab in Remix.
   - Deploy the contract by clicking the "Deploy" button.

3. **Interact with the Contract**:
   - Once deployed, the contract's functions will be available in the Remix interface.
   - Use the provided input fields to call functions like `registerCustomer`, `mint`, `burn`, and `transferPoints`.

### Contract Functions

- **registerCustomer**: Register a customer to allow them to receive loyalty points.
  ```solidity
  function registerCustomer(address customer) public;
  ```

- **mint**: Mint new loyalty points to a registered customer (only callable by the contract owner).
  ```solidity
  function mint(address to, uint256 amount) public onlyOwner;
  ```

- **burn**: Burn loyalty points from a customer's balance.
  ```solidity
  function burn(address from, uint256 amount) public;
  ```

- **transferPoints**: Transfer loyalty points to another customer.
  ```solidity
  function transferPoints(address to, uint256 amount) public;
  ```

- **transferFrom**: Override the standard ERC20 `transferFrom` function to support loyalty points transfers.
  ```solidity
  function transferFrom(address from, address to, uint256 amount) public override returns (bool);
  ```

## Help

For common issues, consider the following:

1. **Compilation Errors**: Ensure you are using the correct Solidity version (0.8.20 or higher).
2. **Deployment Issues**: Check your network configuration and ensure you have sufficient funds  for gas fees.
3. **Function Errors**: Review the function requirements and error messages. Make sure only the contract owner tries to mint tokens and that customers are registered before receiving points.

## Authors

- Vaibhavi Shreya
  - Email: [vaibhavishreya2004@gmail.com](mailto:vaibhavishreya2004@gmail.com)

## License

This project is licensed under the MIT License. See the LICENSE.md file for details.
