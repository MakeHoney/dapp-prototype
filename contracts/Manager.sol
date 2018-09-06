pragma solidity ^0.4.23;

import "./Ownable.sol";
import "./User.sol";

contract Manager is Ownable {
    event comparison(address sender, address owner, bool flag);

    mapping (address => address) accounts;
    mapping (uint32 => address) ids;
    uint32 numOfAccounts;

    constructor() public {
        numOfAccounts = 1;
    }

    modifier isExist(address _userAddr) {
        require(accounts[_userAddr] != 0, "User doesn't exist");
        _;
    }

    /* 이미 등록된 사용자 예외처리 */
    function register(string _name, uint8 _age, uint16 _height, uint16 _weight) external {
        require(accounts[msg.sender] == 0, "Account already exists.");
        msg.sender != owner ? ids[numOfAccounts] = msg.sender : ids[0] = owner;

        if(msg.sender != owner) {
            emit comparison(msg.sender, owner, true);
            /* user account, name, age, grade, height, weight, userIndex */
            accounts[msg.sender] = new User(msg.sender, _name, _age, 0, _height, _weight, numOfAccounts);
            numOfAccounts++;
        } else {
            emit comparison(msg.sender, owner, false);
            /* user account, name, age, grade, height, weight, userIndex */
            accounts[msg.sender] = new User(owner, "Admin", 0, 1, 0, 0, 0);
        }
    }

    function getNumOfUsers() external view onlyOwner returns (uint) {
        return numOfAccounts;
    }

    function getUserContract() external view isExist(msg.sender) returns (address) {
        return accounts[msg.sender];
    }

    function getUserContractById(uint32 _idx) external view returns (address) {
        require(numOfAccounts >= _idx, "Index is not correct.");
        return accounts[ids[_idx]];
    }

    function getBasicUserInfo() public view isExist(msg.sender) returns(
        string,
        uint8,
        uint16,
        uint16
    ) {
        User user = User(accounts[msg.sender]);
        /* memory <-> storage */
        string memory name;
        uint8 age;
        uint16 height;
        uint16 weight;
        (,name,age,,height,weight,) = user.getUserInfo();
        return (name, age, height, weight);
    }

    function getAdditionalUserInfo() external view isExist(msg.sender) returns (
        address,
        uint8,
        uint32
    ) {
        User user = User(accounts[msg.sender]);
        address userAccount;
        uint8 grade;
        uint32 userIndex;
        (userAccount,,,grade,,,userIndex) = user.getUserInfo();
        return (userAccount, grade, userIndex);
    }

    function foo() external view returns (
        uint8[],
        uint16[],
        uint16[]
    ) {
        uint32 size;
        
        /* 6 이상 => 5, 이외 경우 admin (1)을 뺀 전체 계정 수 */
        numOfAccounts > 5 ? size = 5 : size = numOfAccounts - 1;
        /* this is how to use array length as variable not constant*/
        uint8[] memory ages = new uint8[](size);
        uint16[] memory heights = new uint16[](size);
        uint16[] memory weights = new uint16[](size);
        User user;

        for(uint8 i = 0; i < size ; i++) {
            /* admin 계정 제외를 위해서 index 1부터 시작 */
            user = User(accounts[ids[i + 1]]);
            (,,ages[i],,heights[i],weights[i],) = user.getUserInfo();
        }

        return (ages, heights, weights);
    }
}
