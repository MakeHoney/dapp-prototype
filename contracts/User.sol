pragma solidity ^0.4.23;

contract User {
    address owner;
    string name;
    uint8 age;
    uint8 grade;
    uint16 height;
    uint16 weight;
    uint32 userIndex;

    constructor(address _owner, string _name, uint8 _age, uint8 _grade, uint16 _height, uint16 _weight, uint32 _userIndex) public {
        owner = _owner;
        name = _name;
        age = _age;
        grade = _grade;
        height = _height;
        weight = _weight;
        userIndex = _userIndex;
    }

    function getUserInfo() external view returns (
        address,
        string,
        uint8,
        uint8,
        uint16,
        uint16,
        uint32
    ) {
        return (owner, name, age, grade, height, weight, userIndex);
    }
}
