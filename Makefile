
.PHONY: all test clean deploy fund help install snapshot format anvil zktest

DEFAULT_ANVIL_KEY := 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
# remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2  && forge install foundry-rs/forge-std@v1.8.2  && forge install openzeppelin/openzeppelin-contracts@v5.0.2 

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

# zktest :; foundryup-zksync && forge test --zksync && foundryup

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast --ffi

deploy:
	@forge script script/DeployHeroesNft.s.sol:DeployHeroesNft $(NETWORK_ARGS)