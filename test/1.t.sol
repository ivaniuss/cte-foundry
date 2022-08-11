// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/1.sol";

contract DeployChallengeTest is Test {
    DeployChallenge deployChallenge;
    function setUp() public {
        deployChallenge = new DeployChallenge();
    }

    function testComplete() public {
        assertTrue(deployChallenge.isComplete());
    }
}
