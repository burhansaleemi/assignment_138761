const erctoken = artifacts.require("erctoken");

module.exports = function (deployer) {
  deployer.deploy(erctoken);
};
