pragma solidity ^0.6.0;

contract Simplemapping{

    mapping(uint => bool) public mymapping;
    
    function setValue(uint _index) public{
        mymapping[_index] = true;
    }

    mapping (address => bool) public myaddres;
    function setMyAddressTrue() public{
        myaddres[msg.sender] = true;
    }
}