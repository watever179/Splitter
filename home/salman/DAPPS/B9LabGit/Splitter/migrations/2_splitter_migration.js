const splitter = artifacts.require("Splitter");

module.exports = function(deployer) {
  deployer.deploy(splitter,"Splitter Contract");
};
