// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/*
Description:
DoS With Block Gas Limit. Smart contracts can be blocked by expensive loops in large arrays. These loops use too much gas, exceeding limits set by the network.  

Remedy:
Instead, avoid loops or design them to run in multiple transactions.
*/


contract DosGas {

    address[] creditorAddresses;
    bool win = false;

    function emptyCreditors() public {
        if(creditorAddresses.length>1500) {
            creditorAddresses = new address[](0);
            win = true;
        }
    }

    function addCreditors() public returns (bool) {
        for(uint i=0;i<350;i++) {
          creditorAddresses.push(msg.sender);
        }
        return true;
    }

    function iWin() public view returns (bool) {
        return win;
    }

    function numberCreditors() public view returns (uint) {
        return creditorAddresses.length;
    }
}