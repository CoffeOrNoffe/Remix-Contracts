pragma solidity ^0.8.0;

import "./Owned.sol";

contract SharedWallet is Owned{

    struct participant{
        bool allowed;
        uint cooldown;
    }

    mapping (address => participant) public participants ;
    mapping (address => uint) public balances;
    uint public allowance;
    uint public cooldownPW;

    event WalletWhiteListed(address _wallet);
    event AllowanceChanged( uint ammount);

    // The owner is a participant himself
    constructor(){
        participants[owner].allowed = true;
        allowance = 1 ether;
        cooldownPW = 30 days;
    }

    // The owner of the shared wallet can add participants
    function whiteListWallet(address _white) public onlyOwner{
        participants[_white].allowed = true;
        emit WalletWhiteListed(_white);
    }

    // Only participants in the shared wallet can withdraw in the allowance limit and cooldown limit
    function withdraw(address payable _to, uint _amount) public{
        require(participants[msg.sender].allowed, "You are not a participant");
        require(_amount <= balances[msg.sender], "You don't have enough funds" );
        require( _amount <= allowance, "You can't withdraw more than the allowance");
        require(participants[msg.sender].cooldown < block.timestamp, "You still need to wait");
        balances[msg.sender] -= _amount;
        participants[msg.sender].cooldown = block.timestamp + cooldownPW;
        _to.transfer(_amount);
    }
    //Change allowance
    function changeAllowance(uint _newAllowance) public onlyOwner{
        allowance = _newAllowance;
        emit AllowanceChanged(_newAllowance);
    }

    // Owner can withdraw all
    function withdrawAll() public onlyOwner{
        address payable ownerP = payable(owner);
        ownerP.transfer(address(this).balance);
        
    }

    // View participant cooldown remaining 
    // ! Not working yet
    function seeCD(address _participant) public view returns(uint){
        return(cooldownPW-participants[_participant].cooldown);
    }
    // If a participant send funds to the contract his balance increases, 
    // if the sender is not a participant he makes a donation to the owner
    receive() external payable{
        if(participants[msg.sender].allowed == true){
            balances[msg.sender] += msg.value;
        }
        else{
            balances[owner] += msg.value;
        }
    }
}