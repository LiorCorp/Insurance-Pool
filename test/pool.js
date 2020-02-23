const Pool = artifacts.require('Pool');
const Insurance = artifacts.require('Insurance');

contract('Pool', async (accounts) => {
	let exchange;
    let poolType;
    let account1 = accounts[0];
    let account2 = accounts[1];
	beforeEach(function() {
		exchange = 1;
		poolType = 1;
	});
	it('Pools creation', async () => {
		const insuranceInstance = await Insurance.deployed();
        assert.equal(await insuranceInstance.getNbPools(), 0);
        
		// Account1 transferFund
        await insuranceInstance.transferFund(exchange, poolType, { from: account1 });
        // Account2 transferFund
        await insuranceInstance.transferFund(exchange, poolType, { from: account2 });
        // Total pools
        assert.equal(await insuranceInstance.getNbPools(), 2, { from: account1 });
        // Total pools account 1 & 2 
        assert.equal(await insuranceInstance.getUserPoolsNb(), 1, { from: account1 })
        assert.equal(await insuranceInstance.getUserPoolsNb(), 1, { from: account2 })
	});
});
