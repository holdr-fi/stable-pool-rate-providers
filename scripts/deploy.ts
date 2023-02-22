import { ethers } from 'hardhat';

async function main() {
  // const USDCRateProvider = await ethers.getContractFactory('USDCRateProvider');
  // const USDTRateProvider = await ethers.getContractFactory('USDTRateProvider');
  // const usdcRateProvider = await USDCRateProvider.deploy();
  // await usdcRateProvider.deployed();
  // const usdtRateProvider = await USDTRateProvider.deploy();
  // await usdtRateProvider.deployed();
  // console.log(`USDCRateProvider deployed to ${usdcRateProvider.address}`);
  // console.log(`USDTRateProvider deployed to ${usdtRateProvider.address}`);
  const auUSDCRateProvider = await ethers.getContractFactory('bastionUSDCRateProvider');
  const auUSDTRateProvider = await ethers.getContractFactory('bastionUSDTRateProvider');
  const auusdcRateProvider = await auUSDCRateProvider.deploy();
  await auusdcRateProvider.deployed();
  const auusdtRateProvider = await auUSDTRateProvider.deploy();
  await auusdtRateProvider.deployed();
  console.log(`bastionUSDCRateProvider deployed to ${auusdcRateProvider.address}`);
  console.log(`bastionUSDTRateProvider deployed to ${auusdtRateProvider.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
