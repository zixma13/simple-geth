# hello-eth

# Pre-requisite

1. make sure vagrant installed with vbox (Vagrant file can be modified if you want)
2. read 'docs' for more details

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



# Vagrant file will provision below things.

(Below steps you can do it manually by yourself also without Vagrant)

## 1. Create 3 Ubuntu's VMs with ssh access provisioning
```
192.168.66.21 miner1
192.168.66.31 node1
192.168.66.32 node2
```

##  2. Install ethereum packages
``` bash
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository -y ppa:ethereum/ethereum
$ sudo apt-get update
$ sudo apt-get install ethereum -y
```

## 3. Prepare the resources

### 3.1 Create folders
``` bash
$ mkdir -p ~/sample/data
$ mkdir -p ~/sample/init/scripts
```

### 3.2 Create genesis block
``` bash
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

### 3.3 Coding javascript to check balances of all local accounts
``` bash
$ cat <<'EOF' >> ~/sample/init/scripts/utils.js
function checkAllBalances() {
    var totalBal = 0;
    for (var acctNum in eth.accounts) {
        var acct = eth.accounts[acctNum];
        var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
        totalBal += parseFloat(acctBal);
        console.log("  eth.accounts[" + acctNum + "]: \t" + acct + " \tbalance: " + acctBal + " ether");
    }
    console.log("  Total balance: " + totalBal + " ether");
};
EOF
```

## 4. Init a database that uses above genesis block (all nodes MUST be the same)
```
$ geth --datadir ~/sample/data init ~/sample/init/genesis-n15.json
```



