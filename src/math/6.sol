// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
contract FiftyYearsChallenge {
    struct Contribution {
        uint256 amount;
        uint256 unlockTimestamp;
    }
    Contribution[] queue;
    uint256 public head;

    address public owner;
    constructor(address player) payable {
        require(msg.value == 1 ether);

        owner = player;
        queue.push(Contribution(msg.value, block.timestamp + (50 *365 days)));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }
    
    function getValue(uint256 val)public view returns(uint256) {
        return queue[val].amount;
    }

    function upsert(uint256 index, uint256 timestamp) public payable {
        require(msg.sender == owner, "not the owner");

        if (index >= head && index < queue.length) {
            // Update existing contribution amount without updating timestamp.
            Contribution storage contribution = queue[index];
            contribution.amount += msg.value;
        } else {
            // Append a new contribution. Require that each contribution unlock
            // at least 1 day after the previous one.
            require(timestamp >= queue[queue.length - 1].unlockTimestamp + 1 days, "holis");
            Contribution storage contribution;
            contribution.amount = msg.value;
            contribution.unlockTimestamp = timestamp;
            queue.push(contribution);
        }
    }

    function withdraw(uint256 index) public {
        require(msg.sender == owner, "asda");
        require(block.timestamp >= queue[index].unlockTimestamp, "111");

        // Withdraw this and any earlier contributions.
        uint256 total = 0;
        for (uint256 i = head; i <= index; i++) {
            total += queue[i].amount;

            // Reclaim storage.
            delete queue[i];
        }

        // Move the head of the queue forward so we don't have to loop over
        // already-withdrawn contributions.
        head = index + 1;

        msg.sender.transfer(total);
    }
}