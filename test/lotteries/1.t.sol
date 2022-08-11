// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;
import "forge-std/Test.sol";
import "../../src/lotteries/1.sol";
contract GuessTheNumberChallengeTest is Test {
    GuessTheNumberChallenge guessTheNumberChallenge;
    address player;
    function setUp() public {
        guessTheNumberChallenge = new GuessTheNumberChallenge{value:1 ether}();
        player = vm.addr(1);
        vm.deal(player, 1 ether);
        vm.label(address(guessTheNumberChallenge), "challenge");
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(address(player));
        guessTheNumberChallenge.guess{value: 1 ether}(42);
        assertTrue(guessTheNumberChallenge.isComplete());
    }
}
