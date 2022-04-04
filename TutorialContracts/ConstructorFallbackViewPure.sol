pragma solidity ^0.5.13;

contract example{
    mapping (address => uint) public balanceReceived;

    address payable owner;

    constructor() public{
        owner = msg.sender;
    }

    function getOwner() public view returns(address){
        return owner;
    }

    function convertWeiToEth(uint _amountWei) public pure returns(uint){
        return _amountWei / 1 ether;
    }

    function destroySC() public{
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(owner);
    }

    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value; 
    }

    function withdrawMoney(address payable _to, uint _amount) public{
        require(_amount <= balanceReceived[msg.sender], "you dont have enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function () external payable{
        receiveMoney();
    }
}