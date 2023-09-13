// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./JeffToken.sol"; // The original token contract

// A wrapped token contract that wraps the JeffToken
contract WrappedJeffToken is ERC20 {
    JeffToken public jeffToken; // The original token contract

    event Deposit(address indexed from, address indexed to, uint256 value);
    event Withdrawal(address indexed from, address indexed to, uint256 value);

    constructor(JeffToken _jeffToken) ERC20("Wrapped JeffToken", "WJFT") {
        jeffToken = _jeffToken; // Initialize the original token contract
    }

    // Deposit the original tokens and mint the wrapped tokens
    function deposit(uint256 _amount) public {
        require(jeffToken.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        _mint(msg.sender, _amount);
        emit Deposit(msg.sender, address(this), _amount);
    }

    // Burn the wrapped tokens and withdraw the original tokens
    function withdraw(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");
        _burn(msg.sender, _amount);
        require(jeffToken.transfer(msg.sender, _amount), "Transfer failed");
        emit Withdrawal(address(this), msg.sender, _amount);
    }
}
