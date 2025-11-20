# CertiFi Chain (Foundry)

Primo smart contract minimale per collegare un'identità off-chain al relativo hash salvato on-chain.

## Struttura

```
certifi-chain/
├── src/
│   └── CertiFi.sol
├── script/
│   ├── Deploy.s.sol
│   └── Mint.s.sol   # script per storeHash (hash → chain)
├── test/
│   └── CertiFi.t.sol
├── foundry.toml
└── README.md
```

## Requisiti

- [Foundry](https://book.getfoundry.sh/)

## Setup rapido

```bash
forge install
forge build
forge test
```

## Contratto minimale

`CertiFi.sol` espone due sole funzioni:

- `storeHash(bytes32 hashValue)` – salva l'hash calcolato off-chain per `msg.sender`
- `getHash(address user)` – restituisce l'hash associato a un indirizzo

Questo è sufficiente per validare l'intero flusso identità → hash → chain.

## Script

### Deploy

```bash
forge script script/Deploy.s.sol \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

### Store hash (Mint.s.sol)

```bash
CERTIFI_CONTRACT=0x123... \
IDENTITY_HASH=0xabc... \
forge script script/Mint.s.sol \
  --rpc-url $RPC_SEPOLIA \
  --broadcast
```

Lo script legge la variabile `IDENTITY_HASH` (bytes32) e invoca `storeHash`.
