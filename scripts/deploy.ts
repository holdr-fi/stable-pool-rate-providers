import { ethers } from 'hardhat';

async function main() {
  const USDCRateProvider = await ethers.getContractFactory('USDCRateProvider');
  const USDTRateProvider = await ethers.getContractFactory('USDTRateProvider');
  const usdcRateProvider = await USDCRateProvider.deploy();
  await usdcRateProvider.deployed();
  const usdtRateProvider = await USDTRateProvider.deploy();
  await usdtRateProvider.deployed();
  console.log(`USDCRateProvider deployed to ${usdcRateProvider.address}`);
  console.log(`USDTRateProvider deployed to ${usdtRateProvider.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
