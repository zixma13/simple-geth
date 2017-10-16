# hello-eth

# Pre-requisite

1. make sure vagrant installed with vbox (Vagrant file can be modified if you want)
2. read 'docs' for more details

# Vagrant file will provision below things.

## Prepare the resources
``` bash
$ mkdir -p ~/sample/data
$ mkdir -p ~/sample/init/scripts

$ cat <<'EOF' >>~/sample/init/genesis-n15.json
{
  "config": {
        "chainId": 15,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "alloc"      : {},
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "1",
  "extraData"  : "",
  "gasLimit"   : "100000",
  "nonce"      : "0x000000000123456",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00"
}
EOF
```

## Init a database that uses above genesis block (all nodes MUST be the same)
``` bash
$ geth --datadir ~/sample/data init ~/sample/init/genesis-n15.json
```

# How it works
1. clone / download 
2. edit 'myown.properties' file
3. run setup 
   - windows: > powershell.exe .\setup.ps1
   - linux: $ .\setup.sh
   
4. Try basic Geth usage : [docs/basic-geth.md](docs/basic-geth.md)
   - To create private blockchain network using Geth
   - Basic transfer transaction between accounts
   - How P2P works

