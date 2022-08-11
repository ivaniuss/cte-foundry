// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../src/5.sol";
import "forge-std/console.sol";
contract GuessTheSecretNumberChallengeTest is Test {
    GuessTheSecretNumberChallenge target;
    address player;
    function setUp() public {
        target = new GuessTheSecretNumberChallenge{value:1 ether}();
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(player);
        bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
        uint8 res;
        for(uint8 i = 0; i <= type(uint8).max; i++){
            if(keccak256(abi.encodePacked(i)) == answerHash){
                res = i;
                break;
            }
        }
        target.guess{value: 1 ether}(res);
        assertTrue(target.isComplete());
    }
}
