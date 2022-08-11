// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../../src/lotteries/4.sol";
import "forge-std/console.sol";
contract GuessTheNewNumberChallengeTest is Test {
    GuessTheNewNumberChallenge target;
    address player;
    function setUp() public {
        target = new GuessTheNewNumberChallenge{value:1 ether}();
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(player);
        uint8 answer = uint8(
            uint256(
                keccak256(
                    abi.encodePacked(blockhash(block.number - 1), block.timestamp
                    )
                )
            )
        );
        target.guess{value: 1 ether}(answer);
        assertTrue(target.isComplete());
    }
}