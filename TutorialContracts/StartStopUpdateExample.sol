pragma solidity ^0.5.13;

contract StartStopUpdateExample{
    address owner;
    bool public pause;
    constructor() public{
        owner = msg.sender;
    }
    function paused() public{
        require(msg.sender == owner);
        pause = !pause;
    }

    function sendMoney() public payable{
        require(!pause, "Contract is paused by the owner");
    }

    function withdrawAll(address payable _to) public{
        require(msg.sender == owner, "Only owner can do this");
        require(!pause, "Contract is paused by the owner");
        _to.transfer(address(this).balance);
    }
    function destroy(address payable _to) public{
        require(msg.sender == owner);
        selfdestruct(_to);
    }
}