pragma solidity >=0.4.21 <0.6.0;

import './ERC20Interface';

contract ERC20Token is ERC20Interface {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping( address => uint256) public balances;
    mapping( address => mapping( address => uint256)) public allowed;
    
    uint256 public totSupply; //Total number of Tokens
    string public name;       //Descriptive name (eg. MyTokenName)
    uint8 public decimals;    //How many decimals to use when displaying amounts
    string public symbol;     //Short identifier for token (eg. MTK)

    // Create new tokens and assign initial values, including initial amount
    constructor(
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) public {
        balances[msg.sender] = _initialAmount;          // The creator owns all the initial tokens
        totSupply = _initialAmount;                     // update total token supply
        name = _tokenName;                              // Store the token name (used for display only i.e not stored on the blockchain)
        decimals = _decimalUnits;                       // store the number of decimls (used for display only)
        symbol = _tokenSymbol;                          // store the token symbol (used for display only i.e not stored on the blockchain)
    }

    //Transfer tokens from msg.sender to specified address
    function transfer( address _to, uint256 _value) public returns (bool success) {
        require( balances[msg.sender] >= _value, "Insufficient funds for transfer source.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to, _value);          // solhint-disable-line indent, no-unused-vars
        return true;
    }

    //Transfer tokens from one specified address to another
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value,"Insufficient allowed funds for transfer source.");
        balances[_to] += _value;
        balances[_from] -= _value;

        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);          // solhint-disable-line indent, no-unused-vars
        return true
    }

    //Return the current balance (in tokens) of a specified address
    function balanceOf(address _owner) public view returns (uint256 balance){
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);    //// solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    //Return the number of total tokens in circulation
    function totalSupply() public view returns (uint totSupp) {
        return totSupply;
    }

}
