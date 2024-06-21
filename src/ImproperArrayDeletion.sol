// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/*
Improper Array Deletion in Solidity. Remove an element from an array using the “delete” function. However, the length and sequence of the array may not remain as expected.
*/

contract EtherRemoval{
    uint[] public firstArray = [1,2,3,4,5];
    function removeItem(uint i) public{
        delete firstArray[i];
    }
    function getLength() public view returns(uint){
        return firstArray.length;
    }
}

