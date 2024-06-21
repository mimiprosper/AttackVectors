// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/*
A burn function vector attack. To prevent this a modifer should be impplemented to restrict access
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // Define a constant address for the "dead" address
    address constant DEAD = 0x000000000000000000000000000000000000dEaD;

    constructor() ERC20("MyToken", "MTK") {
        // Initial minting of tokens to the deployer of the contract
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Function to burn tokens
    function burn(address account, uint256 amount) public {
        _transfer(account, DEAD, amount);
    }

}