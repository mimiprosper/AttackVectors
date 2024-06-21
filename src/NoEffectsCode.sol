// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/*
Description:
In Solidity, it's possible to write code that does not produce the intended effects. Currently, the solidity compiler will not return a warning for effect-free code. This can lead to the introduction of "dead" code that does not properly performing an intended action.

Example in line 34 of this contract. The "==" operator should be "="

*/

contract NoEffectsCode {
    address payable public NGO;
    uint256 public totalAmountContributed;

    mapping(address donators => uint256 amount) contributionPerUsers;

    event Donate(address indexed user, uint256 indexed amount);

    address public owner;

    constructor() {
        NGO = payable(msg.sender);

        // no effect code in operation. should be owner = msg.sender
        owner == msg.sender;
    }

  modifier admin() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function donate() external payable returns (bool) {
        uint256 amount = msg.value;

        totalAmountContributed += amount;
        contributionPerUsers[msg.sender] += amount;

        emit Donate(msg.sender, amount);
        return true;
    }

    function withdraw(address payable community, uint256 amount) external admin{
        require(amount < address(this).balance, "Insufficient funds");
        (bool success, ) = community.call{value: amount}("");
        require(success, "Failed Transaction");
    }

    receive() external payable {}
}
