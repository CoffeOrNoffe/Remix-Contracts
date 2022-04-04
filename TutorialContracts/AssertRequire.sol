pragma solidity ^0.5.13;

contract ExceptionExample{
    mapping (address => uint64) public balanceReceived;

    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);

    }

    function withdrawMoney(address payable _to, uint64 _amount) public{
        require(balanceReceived[_to] >= _amount,"you dont have enough eth");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}