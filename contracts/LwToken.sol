// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// LwToken realization based on ERC20 standard instructions

contract LW {
    // <============================ ERC20 VARIABLES ===========================>
    string private _name = "LightWood Token";
    string private _symbol = "LW";
    string private _standard = "LightWood Token v1.0 based on ERC20 standard";
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(uint256 _initialSupply) {
        require(msg.sender != address(0), "ERC20: initial address must not be zero");
        
        _totalSupply = _initialSupply;
        _balances[msg.sender] = _initialSupply * (10 ** decimals());
    }

    // <============================ ERC20 FUNCTIONS ===========================>
    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address account) public view returns (uint256 balance) {
        return _balances[account];
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function transfer(address recipient, uint256 amount) public returns (bool success) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address recipient, uint256 amount) public returns (bool success) {
        _approve(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool success) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, msg.sender, currentAllowance - amount);
        }

        return true;
    }

    // <============================ ERC20 INTERNAL FUNCTIONS ===========================>

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address is not allowed");
        require(recipient != address(0), "ERC20: transfer to the zero address is not allowed");

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: tranfser amount exceeds sender's balance ");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal{
        require(owner != address(0), "ERC20: approve from the zero address is not allowed");
        require(spender != address(0), "ERC20: approve to the zero address is not allowed");

        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);
    }

    // <============================ ERC20 EVENTS ===========================>
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    // <============================ LOCAL INTERNAL TOKEN FUNCTIONS ===========================>
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address is not allowed");
        _totalSupply += amount;
        _balances[account] += amount;

        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address is not allowed");
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds account's balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }
}