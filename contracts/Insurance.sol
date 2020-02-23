pragma solidity >=0.4.25 <0.6.0;

import "./Gouvernance.sol";
import "./Owned.sol";

contract Insurance is Gouvernance {

	event TransferFund(address _transferFrom, uint amount);
	event UpdateBalanceExchange(uint idExchange, uint balance);

	function transferFund(uint8 exchange, uint8 poolType) external payable returns (bool) {
        uint16 poolId = joinPool(exchange, poolType);
        updateUserPools(exchange, poolId, user[msg.sender].userPoolsSize, msg.sender);
        pendingWithdrawals[msg.sender] += msg.value;
		return true;
    }

	function getBalance() external view returns (uint) {
		return address(this).balance;
	}
}
