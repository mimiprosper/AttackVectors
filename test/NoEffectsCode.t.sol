// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {NoEffectsCode} from "../src/NoEffectsCode.sol";

contract NoEffectsCodeTest is Test {
    NoEffectsCode public noEffectsCode;

    address payable public attacker = payable(address(1));
    address public userOne = address(3);
    address public ngo = address(2);

    function setUp() external {
        // Fund userOne with 10 ether for testing
        vm.deal(userOne, 10 ether);

        // Deploy the NoEffectsCode contract as the NGO
        vm.startPrank(ngo);
        noEffectsCode = new NoEffectsCode();
        vm.stopPrank();
    }

    function testUnauthorizedWithdraw() external {
        // Simulate userOne donating 10 ether to the NoEffectsCode contract
        vm.startPrank(userOne);
        noEffectsCode.donate{value: 10 ether}();
        vm.stopPrank();

        // Simulate attacker trying to withdraw funds
        vm.startPrank(attacker);
        vm.expectRevert("Not owner");
        noEffectsCode.withdraw(attacker, 5 ether);
        vm.stopPrank();

        // Assert that the contract balance is still 10 ether
        assertEq(address(noEffectsCode).balance, 10 ether);
    }

}
