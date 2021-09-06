// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// LwToken realization based on OpenZepellin ERC20 class

contract LwToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("LightWood", "LWERC20") {
        _mint(msg.sender, _initialSupply * (10 ** decimals()));
    }
    
}