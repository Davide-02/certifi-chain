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

`CertiFi.sol` espone tre funzioni:

- `storeHash(bytes32 hashValue)` – salva l'hash calcolato off-chain per `msg.sender`
- `getHash(address user)` – restituisce l'hash associato a un indirizzo
- `verify(bytes32 hash)` – verifica se un hash è stato salvato sulla blockchain (restituisce `true`/`false`)

Questo è sufficiente per validare l'intero flusso identità → hash → chain.

### Verifica hash dal terminale

Puoi verificare se un hash esiste usando `cast`:

```bash
cast call <CONTRACT_ADDRESS> "verify(bytes32)(bool)" <HASH> --rpc-url http://127.0.0.1:8545
```

Esempio:

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "verify(bytes32)(bool)" \
  0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef \
  --rpc-url http://127.0.0.1:8545
```

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

### Run anvil

```bash
anvil

forge script script/Deploy.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --sender <tuo_address> --private-key <tua_chiave_privata>
```

Copiare contract address e sostituirlo nel BE .env
