# CertiFi Chain (Foundry)

Smart contract per la certificazione digitale tramite NFT.

## Installazione

forge install
forge build
forge test

## Deploy example

forge script script/Deploy.s.sol --rpc-url $RPC_SEPOLIA --broadcast --verify

## Mint example

CERTIFI_CONTRACT=0x123... \
RECIPIENT=0x456... \
TOKEN_URI=ipfs://attestati/1.json \
forge script script/Mint.s.sol --rpc-url $RPC_SEPOLIA --broadcast
