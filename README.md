# Heroes NFT - Justice League Themed On-Chain NFT Project

Heroes NFT is an on-chain NFT collection inspired by Justice League superheroes. Built using **Solidity** and **Foundry**, this project allows users to mint and flip between different superhero-themed SVG logos — all fully stored and rendered on-chain.

## Features

* **Superhero Themed NFTs:** Mint SVG-based logos representing Superman, Batman, and Flash.
* **On-Chain Storage:** Images and metadata are stored and served directly on-chain.
* **Dynamic NFTs:** Owners can flip their NFT between heroes (Superman, Batman, Flash).
* **ERC721 Standard:** Built on OpenZeppelin's ERC721 implementation.

---

## Tech Stack

* **Solidity 0.8.18**
* **Foundry** (Smart contract development framework)
* **OpenZeppelin Contracts v5.x** (ERC721 & utilities)

---

## Contract Overview

### Contract Name: `HeroesNft`

#### Core Components

* **SVG Images:**

  * `s_supermanSvgImageUri`
  * `s_batmanSvgImageUri`
  * `s_flashSvgImageUri`

* **Enums:**

  * `Heroes { SUPERMAN, BATMAN, FLASH }`

* **Mappings:**

  * `s_tokenIdToHeroes` — Maps token IDs to their current hero state.

#### Key Functions

* `constructor(...)`

  * Initializes SVG images and sets up the ERC721 token name and symbol.

* `mintNft()`

  * Mints a new NFT with the default hero (Superman).

* `flipHeroes(uint256 tokenId)`

  * Allows authorized users (owners or approved addresses) to cycle through heroes for a specific token.

* `tokenURI(uint256 tokenId)`

  * Returns the full on-chain metadata including Base64-encoded JSON and SVG image URI.

* `_isAuthorized(address caller, uint256 tokenId)`

  * (OpenZeppelin 5.x) Handles access control for flipping NFTs.

---

## Installation & Setup

1. **Clone the repository**

```bash
git clone <your_repo_url>
cd heroes-nft
```

2. **Install Foundry**

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

3. **Build & Test**

```bash
forge build
forge test
```

---

## Deployment Instructions

### Setup Environment Variables

Before deploying, set up your environment variables:

```bash
export PRIVATE_KEY=<your_private_key>
export RPC_URL=<your_rpc_url>
```

Alternatively, configure your `foundry.toml` file with these settings.

### Deploy the Contract

1. **Write Deployment Script**

Ensure you have a deployment script like `Deploy.s.sol` inside your `script` directory.

Example command:

```bash
forge script script/Deploy.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --verify
```

2. **View Deployment Output**

The terminal will display the deployed contract address. Use this address to interact with your contract post-deployment.

3. **Verify on Etherscan (Optional)**

Include the `--verify` flag in the deployment command to automatically verify the contract on Etherscan.

---

## Usage

* Mint a superhero logo NFT by calling `mintNft()`.
* Flip the hero representation by calling `flipHeroes(tokenId)`.
* View metadata and SVG logo directly using the `tokenURI()` function.

---

## Example Metadata (Decoded)

```json
{
  "name": "Heroes NFT",
  "description": "An NFT that represents your favorite Justice League heroes.",
  "attributes": [
    { "trait_type": "Hero", "value": "Superman" }
  ],
  "image": "data:image/svg+xml;base64,..."
}
```

---

## Future Improvements

* Allow minting of different heroes directly (instead of defaulting to Superman).
* Extend collection to include other Justice League members (Wonder Woman, Green Lantern, etc).
* Frontend UI integration for minting and flipping NFTs.
* Dynamic metadata attributes reflecting flip count or mint date.

---

## License

MIT License.

---

## Author

Bonaventure Edetan
**Contact:** [edetanb@gmail.com](mailto:edetanb@gmail.com)
