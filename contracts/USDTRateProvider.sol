// SPDX-License-Identifier: GPL-3.0-or-later

// Gets latest USDC price from Pyth oracle

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";

contract USDTRateProvider {
  IPyth pyth = IPyth(0xF89C7b475821EC3fDC2dC8099032c05c6c0c9AB9);

  constructor() {
  }

  function getRate() external view returns (uint256 rate) {
    bytes32 priceID = 0x2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b;
    // USDC price ID as per https://pyth.network/developers/price-feed-ids#pyth-evm-mainnet
    PythStructs.Price memory priceData = pyth.getPriceUnsafe(priceID);
    // Pyth USDT price must be multiplied by 1e10 to accommodate Balancer contracts and frontend.
    return uint256(uint64(priceData.price) * 1e10);
  }
}
