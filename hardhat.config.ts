import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import '@nomiclabs/hardhat-etherscan';
import { config as dotenv_config } from 'dotenv';
dotenv_config();
import 'hardhat-gas-reporter';

const config: HardhatUserConfig = {
  solidity: '0.8.0',
  defaultNetwork: 'aurora',
  networks: {
    hardhat: {
      forking: {
        url: 'https://mainnet.aurora.dev',
      },
    },
    aurora: {
      url: process.env.AURORA_URL,
      chainId: 1313161554,
      accounts: JSON.parse(process.env.PRIVATE_KEYS || '[]'),
      gas: 12000000,
      blockGasLimit: 0x1fffffffffffff,
    },
  },
  etherscan: {
    apiKey: {
      aurora: '1GTCE141ABWQGYSH4V47WG3KXAFFB125RC',
    },
  },
  gasReporter: {
    enabled: true,
  },
};

export default config;