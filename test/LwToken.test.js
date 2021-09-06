const LW = artifacts.require("LW");

contract('LightWood-ERC20 Token', (accounts) => {
    before(async () => {
        lw = await LW.deployed();
    })

    it("Should put 5M tokens to the owner account", async() => {
        let balance = await lw.balanceOf(accounts[0]);
        balance = web3.utils.fromWei(balance, 'ether');
        assert.equal(balance, '5000000', "Balance should be 5M tokens for contact creator");
    })
})