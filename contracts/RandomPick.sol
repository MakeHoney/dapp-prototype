pragma solidity ^0.4.23;

import "./Manager.sol";

contract RandomPick is Manager {
    uint8 numOfRandomPick;

    constructor() public {
        numOfRandomPick = 5;
    }
    
    function getRandomInfo() external view returns (
        uint8[],
        uint16[],
        uint16[]
    ) {
        /* this is how to use array length as variable not constant*/
        uint8[] memory ages = new uint8[](numOfRandomPick);
        uint16[] memory heights = new uint16[](numOfRandomPick);
        uint16[] memory weights = new uint16[](numOfRandomPick);

        // for(uint8 i = 0; i < numOfRandomPick ; i++) {
        //     ages.push()
        // }

        return (ages, heights, weights);
    }

    function setNumOfRandomPick(uint8 num) external {
        numOfRandomPick = num;
    }

    // function makeRandomNumArray() private returns (uint8[]) {
    //     uint8[] memory randomNumArray = new uint8[](numOfRandomPick);
    //     uint8 randNum;

    //     for(uint8 i = 0; i < numOfRandomPick ; i++) {
    //         if(numOfAccounts >= numOfRandomPick) {
    //             randNum = uint8(block.timestamp % numOfRandomPick + 1);
    //             while(i != 0) {
    //                 randNum = uint8(block.timestamp % numOfRandomPick + 1);
    //             }
    //             // randomNumArray.push(randNum);
    //         } else {
    //             randNum = block.timestamp % numOfAccounts + 1;
    //         }
    //     }
    // }
}