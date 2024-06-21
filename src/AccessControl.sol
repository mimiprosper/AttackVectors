// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/*
Description:
Common vulnerabilities related to access control The most common vulnerabilities related to access control can be narrowed down as below.

1. Missed Modifier Validations — It is important to have access control validations on critical functions that execute actions like modifying the owner, transfer of funds and tokens, pausing and unpausing the contracts, etc. Missing validations either in the modifier or inside require or conditional statements will most probably lead to compromise of the contract or loss of funds.
2. Incorrect Modifier Names — Due to the developer’s mistakes and spelling errors, it may happen that the name of the modifier or function is incorrect than intended. Malicious actors may also exploit it to call the critical function without the modifier, which may lead to loss of funds or change of ownership depending on the function’s logic.
3. Overpowered Roles — Allowing users to have overpowered roles may lead to vulnerabilities. The practice of least privilege must always be followed in assigning privileges.

Remediation:
Implement access control like onlyOwner in critical functions.

*/

contract AccessControl {
    address payable public NGO;
    uint256 public totalAmountContributed;

    mapping(address donators => uint256 amount) contributionPerUsers;

    event Donate(address indexed user, uint256 indexed amount);

    constructor() {
        NGO = payable(msg.sender);
    }

    function donate() external payable returns (bool) {
        uint256 amount = msg.value;

        totalAmountContributed += amount;
        contributionPerUsers[msg.sender] += amount;

        emit Donate(msg.sender, amount);
        return true;
    }

    function withdraw(address payable community, uint256 amount) external {
        require(amount < address(this).balance, "Insufficient funds");
        (bool success, ) = community.call{value: amount}("");
        require(success, "Failed Transaction");
    }

    receive() external payable {}
}
