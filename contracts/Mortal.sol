pragma solidity ^0.4.23;

import "./Ownable.sol";

contract Mortal is Ownable {
    function kill() public onlyOwner {
        selfdestruct(owner);
    }
}
