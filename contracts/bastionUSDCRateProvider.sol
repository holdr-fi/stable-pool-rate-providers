// SPDX-License-Identifier: GPL-3.0-or-later

// Obtain auUSDC price using Pyth oracle for USDC price, and auUSDC contract for auUSDC/USDC price
pragma solidity ^0.8.0;

import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";
import "./IAuERC20.sol";

contract bastionUSDCRateProvider {
  IPyth pyth = IPyth(0xF89C7b475821EC3fDC2dC8099032c05c6c0c9AB9);
  // bastion cUSDC
  IAuERC20 auUSDC = IAuERC20(0xe5308dc623101508952948b141fD9eaBd3337D99);

  constructor() {
  }

  function getRate() external view returns (uint256 rate) {
    // USDC price ID as per https://pyth.network/developers/price-feed-ids#pyth-evm-mainnet
    bytes32 priceID = 0xeaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a;
    PythStructs.Price memory priceData = pyth.getPriceUnsafe(priceID);
    // Pyth USDC price must be multiplied by 1e10 to accommodate Balancer contracts and frontend.
    uint256 usdcPrice = uint256(uint64(priceData.price)) * 1e10;

    // USDC amount = auUSDC amount * USDC_per_auUSDC_rate
    uint256 USDC_per_auUSDC_rate = auUSDC.exchangeRateStored() * 1e2;
    uint256 auUSDCprice = usdcPrice * USDC_per_auUSDC_rate / 1e18;
    return auUSDCprice;
  }
}