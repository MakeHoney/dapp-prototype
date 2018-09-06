pragma solidity ^0.4.23;

import "./Ownable.sol";
import "./User.sol";

contract Manager is Ownable {
    event comparison(address sender, address owner, bool flag);

    mapping (address => address) accounts;
    mapping (uint32 => address) ids;
    uint32 numOfAccount;

    constructor() public {
        numOfAccount = 1;
    }

    /* grade 실행제어자 설정하기 */
    function register(string _name, uint8 _age, uint16 _height, uint16 _weight) public {
        require(accounts[msg.sender] == 0, "Account already exists.");
        msg.sender != owner ? ids[numOfAccount] = msg.sender : ids[0] = owner;

        if(msg.sender != owner) {
            emit comparison(msg.sender, owner, true);
            /* user account, name, age, grade, height, weight, userIndex */
            accounts[msg.sender] = new User(msg.sender, _name, _age, 0, _height, _weight, numOfAccount);
            numOfAccount++;
        } else {
            emit comparison(msg.sender, owner, false);
            accounts[msg.sender] = new User(owner, "Admin", 0, 1, 0, 0, 0);
        }
    }

    function getNumOfUsers() external view onlyOwner returns (uint) {
        return numOfAccount;
    }

    function getUserContract(address _userAddr) public view returns (address) {
        require(accounts[_userAddr] != 0, "User account is not correct.");
        return accounts[_userAddr];
    }

    function getUserContractById(uint32 _idx) public view returns (address) {
        require(numOfAccount >= _idx, "Index is not correct.");
        return accounts[ids[_idx]];
    }

    function getBasicUserInfo(address _userAddr) public view returns(
        string,
        uint8,
        uint16,
        uint16
    ) {
        require(accounts[_userAddr] != 0, "User account is not correct.");
        User user = User(accounts[_userAddr]);
        /* memory <-> storage */
        string memory name;
        uint8 age;
        uint16 height;
        uint16 weight;
        (,name,age,,height,weight,) = user.getUserInfo();
        return (name, age, height, weight);
    }

    // addr이 필요한가?
    function getAdditionalUserInfo(address _userAddr) public view returns (
        address,
        uint8,
        uint32
    ) {
        require(accounts[_userAddr] != 0, "User account is not correct.");
        User user = User(accounts[_userAddr]);
        address userAccount;
        uint8 grade;
        uint32 userIndex;
        (userAccount,,,grade,,,userIndex) = user.getUserInfo();
        return (userAccount, grade, userIndex);
    }
}
