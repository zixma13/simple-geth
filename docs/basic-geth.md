# Miner node (169.254.142.21)

## 1. Create new account 
```
$ geth --datadir ~/sample/data account new
```

### eg. 
- acc0: 0xf1c05e4867ce94c2ea9e86839751c773c06dfa18   passphrase: xxx

## 2. Start mining (and transfer Gas to the created account)
```
$ geth --datadir ~/sample/data --networkid 15 --etherbase 
```
- '0xf1c05e4867ce94c2ea9e86839751c773c06dfa18' --mine
- (Waiting until 'Generating DAG' is completed)
- (if 'Done generating DAG for epoch 0' that means ..... the difficalty has been setup is to high (just decrease and re-init or waiting)

## 3. Open javascript console of running mine (by attach process)
$ geth attach ipc:```[full/path/of/geth.ipc]``` for example:
```
$ geth attach ipc:/home/amusikapan/sample/data/geth.ipc
```


## 4. Import script from console 
``` javascript
> loadScript("/home/amusikapan/sample/scripts/geth_utils.js")
```
- ( the '>' leading means -> using javascript console)
- ( the '$' leading means -> using bash console)


## 5. Call function in script 
```
> checkAllBalances();
```

## 6. Get node info (if another nodes need to connect)
``` javascript
> admin.nodeInfo
```
> Eg -> enode: 
> "enode://c3a263bf9701f777e27b401f4372297182b1fdfccea45ac1f6785d1100868cca4f01b640887598f27471ce048287bea3bb4dcec7d7de3f87ef547fc9a4c0602a@[::]:30303")




# Node1 (169.254.142.31)

## 1. Create account 
```
$ geth --datadir ~/sample/data account new
```
### eg. 
  - acc: 0xcf6a800968a94f4d0408e3daf32be8767cc30aa6 , passphrase: xxx

## 2. Accessing boot node with the same networkid and access the console.
(from miner's enode so replace [::] with miner node's IP address)
```
$ geth --datadir ~/sample/data --networkid 15 --bootnodes enode://4947c74c60285b583396f6915c8f422c492a34855f9144dad5c808b0039691705e03589cee6a847824f14d7d99f2b581f3c2351e7f0586e0caf375a1744b228a@169.254.142.21:30303 console
```

> note : 
> - have to use the same 'networkid' for all nodes


## 3. Get balances (using script)
``` 
> loadScript("/home/amusikapan/sample/scripts/geth_utils.js")
> checkAllBalances();
```
or uing 'eth' 
```
> eth.getBalance("0xcf6a800968a94f4d0408e3daf32be8767cc30aa6")
```

# Transfer transaction from miner account to account in node1

-  note: 0.000000000000000001 eather = 1 wei

## 1. From node miner1 - send transction
``` javascript
> var tx = {from: "0xf1c05e4867ce94c2ea9e86839751c773c06dfa18", to: "0xcf6a800968a94f4d0408e3daf32be8767cc30aa6", value: web3.toWei(100000, "wei")}
> personal.sendTransaction(tx, "xxx")
```

## 2. Get available balance (when transaction completed)
> eth.getBalance("0xf1c05e4867ce94c2ea9e86839751c773c06dfa18")

To check transaction status
```
> txpool.content
> txpool.inspect
```

> Pending transaction depends on cpu, difficalty (changed everytimes block mined)

## 3. send more !!
``` javascript
> var tx = {from: "0xf1c05e4867ce94c2ea9e86839751c773c06dfa18", to: "0xcf6a800968a94f4d0408e3daf32be8767cc30aa6", value: web3.toWei(0.00017, "ether")}
> personal.sendTransaction(tx, "xxx")
```
(if got the results -> "Error: exceeds block gas limit" so calculate the block capability again)

## 4. Check node1's account balance
``` javascript
> eth.getBalance("0xcf6a800968a94f4d0408e3daf32be8767cc30aa6")
```

# node2 connect to node1 (as bootnodes) 

## 1. Prepare folders
``` bash 
$ mkdir -p ~/sample
$ mkdir -p ~/sample/data
$ mkdir -p ~/sample/scripts
```

## 2. Create account 
``` bash
$ geth --datadir ~/sample/data account new
```
e.g. 
- acc: 0x317ced0422aefac3ba4e3b9e4efd5dfe6532af4d , passphrase: xxx

## 3. Initial genesis as the same as miner node (genesis file must be the same as all nodes in the same network)
``` bash
$ geth --datadir ~/sample/data init ~/sample/init/genesis-n15.json
```

## 4. Accessing node1 as a boot node
( from miner enode so replace [::] with miner node's IP addr )
``` bash
$ geth --datadir ~/sample/data --networkid 15 --bootnodes enode://e642e27701b9625d21f71095dba93e4bb068101bd82dbea381b2e5504ad1928d55fd7fcd16fbc55cb2f77e444e9cc00f796fb1a66bd714ec09656f66d762195c@169.254.142.31:30303
```

## 5. Access javascript console
``` bash
$ geth attach ipc:///home/amusikapan/sample/data/geth.ipc
```

## 6. Copy javascript from miner to same folder (can be different)
## 7. Get balance 
``` bash
> loadScript("/home/amusikapan/sample/scripts/geth_utils.js")
> checkAllBalances();
```



#  Testing decentralize concept 

( Testing p2p concept by transfer transaction from miner's account to node2's account )

## 1. From miner1 console
``` javascript
> var tx = {from: "0xf1c05e4867ce94c2ea9e86839751c773c06dfa18", to: "0x317ced0422aefac3ba4e3b9e4efd5dfe6532af4d", value: web3.toWei(100000, "wei")}
> personal.sendTransaction(tx, "xxx")
```

## 2. From node2 console
```
> eth.getBalance("0x317ced0422aefac3ba4e3b9e4efd5dfe6532af4d")
```


# Learning steps
1. https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum
2. https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts
3. https://github.com/ethereum/go-ethereum/wiki/Mining
   (javascrip console: https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console)
4. https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions

5. Networking 
   - https://github.com/ethereum/go-ethereum/wiki/Connecting-to-the-network
   - https://github.com/ethereum/go-ethereum/wiki/Private-network
   - https://github.com/ethereum/go-ethereum/wiki/Setting-up-private-network-or-local-cluster

6. https://github.com/ethereum/go-ethereum/wiki/Management-APIs
7. https://github.com/ethereum/go-ethereum/wiki/Backup-&-restore
8. https://medium.com/taipei-ethereum-meetup/beginners-guide-to-ethereum-3-explain-the-genesis-file-and-use-it-to-customize-your-blockchain-552eb6265145

## Other useful link 
1. [Ether converter](https://etherconverter.online/)