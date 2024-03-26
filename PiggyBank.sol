// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/**
 * @dev everyone can deposit, only the owner can withdraw
 */

contract PiggyBank {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "You are not the owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(owner));
    }
}

/**
 * @dev since selfdestruct is deprecated, we can use a boolean to deactivate the contract
 */

contract PiggyBankBool {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    address public owner = msg.sender;
    bool public isContractActive = true;

    receive() external payable {
        require(isContractActive, "Contract is not active");
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "You are not the owner");
        require(isContractActive, "Contract is not active");
        emit Withdraw(address(this).balance);
        isContractActive = false;
    }
}
