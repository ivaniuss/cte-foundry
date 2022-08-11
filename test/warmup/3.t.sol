// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13 <0.9.0;
import "forge-std/Test.sol";
import "../../src/warmup/3.sol";
import "forge-std/console.sol";
contract CaptureTheEtherTest is Test {
    CaptureTheEther captureTheEther;
    NicknameChallenge nicknameChallenge;
    address player = vm.addr(1);
    function setUp() public {
        vm.startPrank(address(player));
        vm.deal(player, 1 ether);
        captureTheEther = new CaptureTheEther();
        nicknameChallenge = new NicknameChallenge(player);

    }

    function testComplete() public {
        // vm.startPrank(address(player));
        captureTheEther.setNickname(0xFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000F);
        assertEq(captureTheEther.getNickname(player)[0] != 0, true);
        // assertEq(nicknameChallenge.isComplete(), false);
    }
}
