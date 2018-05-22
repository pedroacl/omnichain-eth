pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Product.sol";

contract TestProduct {
    function testCreateProduct() public {
        // Assert.equal(true, true);
        MetaCoin meta = MetaCoin(DeployedAddresses.MetaCoin());

    }
}
