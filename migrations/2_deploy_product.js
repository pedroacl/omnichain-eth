var Product = artifacts.require("./ProductFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(Product);
};
