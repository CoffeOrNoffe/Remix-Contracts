pragma solidity ^0.5.13;

contract sendmoney{

    uint public balanceReceived;
    function receiveMoney() public payable{
        balanceReceived += msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw() public{
        address payable to = msg.sender;
        
        to.transfer(balanceReceived);
        balanceReceived = 0;
    }
    function withdrawTo(address payable _to) public{
        _to.transfer(getBalance());
    }
}