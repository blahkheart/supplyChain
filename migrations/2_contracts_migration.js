const ERC20Token = artifacts.require("ERC20Token");
const supplyChain = artifacts.require("supplyChain");

module.exports = function (deployer) {
  deployer.deploy(ERC20Token, 10000, "TotalSem Token", 18,"TotalSem");
  deployer.deploy(supplyChain);
};
