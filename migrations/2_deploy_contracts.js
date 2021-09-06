//const LwToken = artifacts.require("LwToken");
const LW = artifacts.require("LW");

module.exports = function(deployer) {
    deployer.deploy(LW, 5000000);
}