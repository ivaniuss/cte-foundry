// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../../src/lotteries/5.sol";
import "forge-std/console.sol";
contract PredictTheFutureChallengeTest is Test {
    PredictTheFutureChallenge target;
    address player;
    function setUp() public {
        target = new PredictTheFutureChallenge{value:1 ether}();
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(player);
        vm.roll(10);    
        uint8 answer = 0;
        target.lockInGuess{value: 1 ether}(0);
        while(true){
            vm.roll(block.number+1);
            uint8 answer1 = uint8(
                uint256(
                    keccak256(
                        abi.encodePacked(blockhash(block.number - 1), block.timestamp
                        )
                    ) 
                )
            )% 10;
            if(answer == answer1){
                console.log('answer', answer, answer1);
                break;
            }
        }
        target.settle();
        assertTrue(target.isComplete());
    }
}