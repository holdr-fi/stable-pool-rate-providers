// import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
// import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from 'chai';
import { ethers } from 'hardhat';
import { USDCRateProvider, USDTRateProvider } from '../typechain-types';
import { BigNumber as BN, Contract } from 'ethers';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

// https://docs.google.com/spreadsheets/d/1pBq1jnpRsFPQROkk3lpfFHi4Km-GUKxnZbeWocly1T8/edit#gid=1647682004

describe('Rate Provider', function () {
  let usdcRateProvider: USDCRateProvider;
  let usdtRateProvider: USDTRateProvider;
  let auUSDCRateProvider: Contract;
  let auUSDTRateProvider: Contract;
  let owner: SignerWithAddress;

  before(async () => {
    [owner] = await ethers.getSigners();
    const USDCRateProvider = await ethers.getContractFactory('USDCRateProvider');
    const USDTRateProvider = await ethers.getContractFactory('USDTRateProvider');
    const AuUSDCRateProvider = await ethers.getContractFactory('auUSDCRateProvider');
    const AuUSDTRateProvider = await ethers.getContractFactory('auUSDTRateProvider');
    usdcRateProvider = await USDCRateProvider.deploy();
    usdtRateProvider = await USDTRateProvider.deploy();
    auUSDCRateProvider = await AuUSDCRateProvider.deploy();
    auUSDTRateProvider = await AuUSDTRateProvider.deploy();
  });

  describe('Test getRate', function () {
    it('Test getRate', async function () {
      const [usdcRate, usdtRate, auUSDCRate, auUSDTRate] = await Promise.all([
        usdcRateProvider.getRate(),
        usdtRateProvider.getRate(),
        auUSDCRateProvider.getRate(),
        auUSDTRateProvider.getRate(),
      ]);
      console.log(usdcRate);
      console.log(usdtRate);
      console.log(auUSDCRate);
      console.log(auUSDTRate);
      console.log(usdcRate.div(usdtRate));
    });
  });
});
