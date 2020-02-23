pragma solidity >=0.4.25 <0.6.0;

import "./Model.sol";

contract Pool is Model {

    Pool[] allPool;
    mapping (uint => uint) poolCreationDate;
    mapping (address => User) user;
    mapping (uint => address payable[]) poolUsers;
    mapping (address => uint) public pendingWithdrawals;

    uint poolDuration = 20 seconds;

    function incrementPool(uint8 exchange, uint8 poolType) public {
        uint16 poolId = uint16(getNbPools() + 1);
        uint8[] memory exchanges = new uint8[](1);
        exchanges[0] = exchange;
        Pool memory newPool = Pool(poolId, poolType, exchanges);
        allPool.push(newPool);
    }

    function createPool(uint8 exchange, uint8 poolType) private returns(uint16)  {
        uint16 poolId = uint16(getNbPools() + 1);
        uint8[] memory exchanges = new uint8[](1);
        exchanges[0] = exchange;
        Pool memory newPool = Pool(poolId, poolType, exchanges);
        allPool.push(newPool);
        //updatePoolExchanges(exchange, poolId);
        return poolId;
    }
    //add exchange in pool (max 10 exchanges by pool)
    function updatePoolExchanges(uint8 exchange, uint16 poolId) private {
        allPool[poolId-1].exchanges.push(exchange);
    }
    //join pool available
    function joinPool(uint8 exchange, uint8 poolType) internal returns(uint16) {
        uint16 poolAvailableId = findPoolAvailable(exchange, poolType);
        if (poolAvailableId == 0) {
            poolAvailableId = createPool(exchange, poolType);
        } else {
            updatePoolExchanges(exchange, poolAvailableId);
        }

        if (getPoolExchangesNb(poolAvailableId) == 3) {
            startPool(poolAvailableId);
        }
        return poolAvailableId;
    }

    function findPoolAvailable(uint8 exchange, uint8 poolType) public view returns(uint16) {
        bool poolFind = false;
        for(uint i = 0; i < allPool.length; i++) {
            poolFind = true;
            // loop through pool's "exchanges"
            if (allPool[i].exchanges.length < 10) {
                // check if "poolType" matches
                if (allPool[i].poolType == poolType) {
                    for (uint y = 0; y < allPool[i].exchanges.length; y++) {
                        // if "exchange" is already in pool set "poolFind" to false
                        if (allPool[i].exchanges[y] == exchange) {
                            poolFind = false;
                        }
                    }
                    if (poolFind) {
                        return allPool[i].id;
                    }
                }
            }
        }
        return 0;
    }

    function startPool(uint16 poolId) private {
        poolCreationDate[poolId] = now + poolDuration;
    }

    function endPool(uint16 poolId) external onlyOwner() {
        uint remainingTimePool = getRemainingTimePool(poolId);
        require(remainingTimePool > poolDuration);
        address payable[] memory accounts =  poolUsers[poolId];
        for (uint i=0; i<accounts.length; i++) {
            address payable account = accounts[i];
            withdraw(account);
        }

    }

    function getRemainingTimePool(uint poolId) public view returns(uint time) {
        return now - poolCreationDate[poolId];
    }

    function updateUserPools(uint8 exchange, uint16 poolId, uint8 index, address payable account) internal {
        user[msg.sender].userPools[index] = UserPool(poolId, exchange);
        user[msg.sender].userPoolsSize++;
        poolUsers[poolId].push(account);
    }

    function withdraw(address payable account) private onlyOwner() {
        uint amount = pendingWithdrawals[account];
        pendingWithdrawals[account] = 0;
        account.transfer(amount);
    }

    /*
    GETTERS
    */

    function getUserPoolsNb() public view returns(uint8) {
        return user[msg.sender].userPoolsSize;
    }

    function getUserPools(uint8 index) external view returns (uint16, uint8)
    {
        return (user[msg.sender].userPools[index].idPool, user[msg.sender].userPools[index].exchange);
    }

    function getNbPools() public view returns(uint) {
        return allPool.length;
    }

    function getNbPoolsPending() public view returns(uint) {
        Pool[] memory poolsPending = new Pool[](allPool.length);
        for(uint i = 0; i < allPool.length; i++) {
            if (allPool[i].exchanges.length < 10) {
                poolsPending[i] = allPool[i];
            }
        }
        return poolsPending.length;
    }

    function getPoolExchangesNb(uint poolId) private view returns(uint) {
        for(uint i = 0; i < allPool.length; i++) {
            if (allPool[i].id == poolId) {
                return allPool[i].exchanges.length;
            }
        }
        return 0;
    }

    function getMyPoolIdByIndex(uint8 index) public view returns(uint16) {
        return user[msg.sender].userPools[index].idPool;
    }
}
