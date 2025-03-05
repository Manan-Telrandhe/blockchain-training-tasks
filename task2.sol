// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract token {
    string public name = "dtoken";
    string public symbol = "symboltoken";
    uint public totalsupply = 1000000000000000000;
    uint public decimals = 18;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping (address=> uint256) public balanceof;
    mapping (address => mapping (address =>  uint256)) public allowance;

    constructor() {
        balanceof[msg.sender] = totalsupply;
    }

    function transfer(address _to, uint256 _value)public returns (bool success){
        require(balanceof[msg.sender] >=_value,"insufficient balance"); 
        balanceof[msg.sender] -= _value;
        balanceof[_to]+=_value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender ,uint256 _value)public returns (bool success){ 
        allowance[msg.sender][_spender] = _value;
        emit Approval(_spender, msg.sender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require (_value <= balanceof[_from]);
        require (_value <= allowance[_from][msg.sender]);
        balanceof[_from] -= _value;
        balanceof[_to] += _value;
        allowance[_from][msg.sender] -=  _value;
        emit Transfer(_from,_to,_value);
        return true;
    }

}   
