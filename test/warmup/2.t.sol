// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/warmup/2.sol";

contract CallMeChallengeTest is Test {
    CallMeChallenge callMeChallenge;
    function setUp() public {
        callMeChallenge = new CallMeChallenge();
    }

    function testComplete() public {
        assertEq(callMeChallenge.isComplete(), false);
        callMeChallenge.callme();
        assertEq(callMeChallenge.isComplete(), true);
    }
}
