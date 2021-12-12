pragma solidity ^0.8.10;

contract Token {
    mapping(address=>uint) public balances;
    mapping(address=> mapping(address=>uint)) allowance;

    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "Farshid Token";
    string public symbol = "FTK";
    uint public decimals = 18;
    event Transfer(address indexed from, address indexed to , uint value);
    event Approval( address indexed owner,address indexed spender , uint value);

    constructor(){
        balances[msg.sender] = totalSupply;
    }
    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from) >= value,'pool kam dari');
        require (allowance[from][msg.sender] >= value, 'allowance too low');
        balances[to]+=value;
        
        balances[from]-=value;
        emit Transfer(from, to ,value);
        return true;
    }
    
    function approve(address spender,uint value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender,value);
        return true;
    }

    function transfer(address to,uint value) public returns(bool){
        require(balanceOf(msg.sender)>=value, 'pool kam dari');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender,to,value);
        return true;
    }

    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
}