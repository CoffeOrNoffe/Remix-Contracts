pragma solidity ^0.8.0;
contract Owned{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    function getOwner() public view returns(address){
        return owner;
    }
}