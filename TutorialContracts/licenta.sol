pragma solidity ^0.8.0;

contract cars{

    // modifier for licensed wallets ( authorized services )
    modifier onlyLicensed{

        _;
    }


    struct carStructure{
        mapping(string => bytes32) carsOwned;
    }

    mapping (address => bool) licensedWallets;
    mapping (address => carStructure)  owners ;

    // Add a car to the owner
    // A.k.a  The owner bought a car
    function addCar(address _owner,string memory _carName, uint _seris) public onlyLicensed{

        owners[_owner].carsOwned[_carName] = keccak256(abi.encode( _seris));

    }

    function verif(address _owner, string memory _carName) public view returns(bytes32){
        return owners[_owner].carsOwned[_carName];
    }

    // if you changed a piece update the piece series
    function repairNotice(address _owner, string memory _carName,uint _newSeries ) public onlyLicensed{

    }

}