// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Functionality
// Only contract owner should be able to mint tokens 
// Any user can transfer tokens 
// Any user can burn tokens 



contract SupermarketLoyaltyPoints is ERC20, Ownable {

    struct Customer {
        bool registered;
    }

    mapping(address => Customer) public customers;

    constructor()ERC20("SupermarketLoyaltyPoints", "SLP")Ownable(msg.sender){}


    function registerCustomer(address customer) public{
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

    function transferPoints( address to, uint256 amount) public {
         transfer( to, amount);
    }
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        return super.transferFrom(from, to, amount);
    }
}
