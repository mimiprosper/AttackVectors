// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/Burn.sol";

contract BurnTest is Test {
    MyToken token;

    function setUp() public {
        token = new MyToken();
    }

    function testBurn() public {
        address account = address(this);
        uint256 burnAmount = 100 * 10 ** token.decimals();
        
        // Mint some tokens to this test contract
        token.transfer(account, burnAmount);

        uint256 initialBalance = token.balanceOf(account);
        token.burn(account, burnAmount);
        uint256 finalBalance = token.balanceOf(account);

        assertEq(initialBalance - burnAmount, finalBalance);
        assertEq(token.balanceOf(0x000000000000000000000000000000000000dEaD), burnAmount);
    }
}