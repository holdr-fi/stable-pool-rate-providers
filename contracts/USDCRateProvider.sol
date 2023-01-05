// SPDX-License-Identifier: GPL-3.0-or-later

// Gets latest USDC price from Pyth oracle

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract USDCRateProvider {
  IPyth pyth = IPyth(0xF89C7b475821EC3fDC2dC8099032c05c6c0c9AB9);

  constructor() {
  }

  function getRate() external view returns (uint256 rate) {
    // USDC price ID as per https://pyth.network/developers/price-feed-ids#pyth-evm-mainnet
    bytes32 priceID = 0xeaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a;
    PythStructs.Price memory priceData = pyth.getPriceUnsafe(priceID);
    // Pyth USDC price must be multiplied by 1e10 to accommodate Balancer contracts and frontend.
    return uint256(uint64(priceData.price)) * 1e10;
  }
}
