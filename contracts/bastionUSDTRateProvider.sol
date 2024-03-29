// SPDX-License-Identifier: GPL-3.0-or-later

// Obtain auUSDT price using Pyth oracle for USDT price, and auUSDT contract for auUSDT/USDT price
pragma solidity ^0.8.0;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";
import "./IAuERC20.sol";

contract bastionUSDTRateProvider {
  IPyth pyth = IPyth(0xF89C7b475821EC3fDC2dC8099032c05c6c0c9AB9);
  // bastion cUSDT
  IAuERC20 auUSDT = IAuERC20(0x845E15A441CFC1871B7AC610b0E922019BaD9826);

  constructor() {
  }

  function getRate() external view returns (uint256 rate) {
    bytes32 priceID = 0x2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b;
    // USDT price ID as per https://pyth.network/developers/price-feed-ids#pyth-evm-mainnet
    PythStructs.Price memory priceData = pyth.getPriceUnsafe(priceID);
    // Pyth USDT price must be multiplied by 1e10 to accommodate Balancer contracts and frontend.
    uint256 usdtPrice = uint256(uint64(priceData.price)) * 1e10;

    // USDT amount = auUSDT amount * USDT_per_auUSDT_rate
    uint256 USDT_per_auUSDT_rate = auUSDT.exchangeRateStored() * 1e2;
    uint256 auUSDTprice = usdtPrice * USDT_per_auUSDT_rate / 1e18;
    return auUSDTprice;
  }
}