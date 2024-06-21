// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/DosGas.sol";

contract DosGasTest is Test {
    DosGas dosGas;

    function setUp() public {
        dosGas = new DosGas();
    }

    function testAddCreditors() public {
        bool result = dosGas.addCreditors();
        assertTrue(result);
        assertEq(dosGas.numberCreditors(), 350);
    }

    function testEmptyCreditors() public {
        for (uint i = 0; i < 5; i++) {
            dosGas.addCreditors();
        }
        assertEq(dosGas.numberCreditors(), 1750);

        dosGas.emptyCreditors();
        assertEq(dosGas.numberCreditors(), 0);
        assertTrue(dosGas.iWin());
    }

    function testWinCondition() public {
        for (uint i = 0; i < 5; i++) {
            dosGas.addCreditors();
        }
        assertFalse(dosGas.iWin());

        dosGas.emptyCreditors();
        assertTrue(dosGas.iWin());
    }
}