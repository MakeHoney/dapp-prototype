pragma solidity ^0.4.23;

import "./Ownable.sol";
import "./User.sol";

contract Manager is Ownable {
    // event 생성하기 

    mapping (address => address) accounts;
    mapping (uint32 => address) ids;
    uint32 numOfAccount;

    constructor() public {
        numOfAccount = 0;
    }

    /* grade 실행제어자 설정하기 */
    function register(string _name, uint8 _age, uint8 _grade, uint16 _height, uint16 _weight) public {
        require(accounts[msg.sender] == 0, "Account already exists.");
        ids[numOfAccount] = msg.sender;
        accounts[msg.sender] = new User(msg.sender, _name, _age, _grade, _height, _weight, numOfAccount);
        numOfAccount++;
    }

    function getNumOfUsers() external view onlyOwner returns (uint) {
        return numOfAccount;
    }

    function getUserContract(address _userAddr) public view returns (address) {
        require(accounts[_userAddr] == 0, "User account is not correct.");
        return accounts[_userAddr];
    }

    function getUserContractById(uint32 _idx) public view returns (address) {
        require(numOfAccount > _idx, "Index is not correct.");
        return accounts[ids[_idx]];
    }

    function getBasicUserInfo(address _userAddr) public view returns(
        string,
        uint8,
        uint16,
        uint16
    ) {
        require(accounts[_userAddr] == 0, "User account is not correct.");
        User user = User(accounts[_userAddr]);
        string name;
    }

    // addr이 필요한가?
    function getAdditionalUserInfo(address _userAddr) public view returns (
        address,
        uint8,
        uint32
    ) {
        require(accounts[_userAddr] == 0, "User account is not correct.");
        User user = User(accounts[_userAddr]);
        address addr;
        uint8 grade;
        uint32 userIndex;
        (addr,,,grade,,,userIndex) = user.getUserInfo();
        return (addr, grade, userIndex);
    }
}
