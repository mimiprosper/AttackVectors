// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/ImproperArrayDeletion.sol";

contract EtherRemovalTest is Test {
    EtherRemoval etherRemoval;

    function setUp() public {
        etherRemoval = new EtherRemoval();
    }

    function testInitialLength() public view {
        uint length = etherRemoval.getLength();
        assertEq(length, 5);
    }

    function testRemoveItem() public {
        etherRemoval.removeItem(2); // Removing the item at index 2 (which is 3)
        uint length = etherRemoval.getLength();
        assertEq(length, 5);

        // Check the value at index 2 is now zero
        uint value = etherRemoval.firstArray(2);
        assertEq(value, 0);
    }
}