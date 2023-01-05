# Rate provider contracts for Balancer Stable Pools, wrapper contracts around Pyth oracle

Rate provider contracts exposing a `getRate()` function required for Balancer Stable Pool creation. Essentially a wrapper API around Pyth Oracle. Uses Pyth SDK - https://github.com/pyth-network/pyth-sdk-solidity

# Caveats

Pyth smart contract address and price feed IDs are hardcoded into the RateProvider smart contracts. So if these variables change on the Pyth oracle side, or the Pyth oracle fails, we need to pause (and possibly migrate liquidity and re-deploy) the Stable Pools reading from these rate providers.

Using getPriceUnsafe() function - Unsafe seems to mean taking a price that gets updated every 30 minutes, rather than every minute. Cannot use getPrice() because it errors out.

# Deployment Addresses

**Current Deployments**

USDCRateProvider deployed to 0x6e2f7a0291872380292b40dEaC7F4dcD587daaAB

USDTRateProvider deployed to 0x723Da95511ebe7320AD22D92fa273A0EAf1993D1

**Deprecated Deployments**

*Deprecated 6 Jan 2023 as discovered that Balancer price rate must be normalised to 18 decimal points, and will not accept Pyth price as-if without normalising*

USDCRateProvider deployed to 0x6D80Dc92E4599ADBaE3E4797EBE79c29d0f4c344

USDTRateProvider deployed to 0x8caCbA163be8070760F6DdADA7461a558519A9F1

# Resources

Pyth smart contract - https://etherscan.deth.net/address/0x4305FB66699C3B2702D4d05CF36551390A4c69C6#code

Price Feed Ids
https://pyth.network/developers/price-feed-ids#pyth-evm-mainnet