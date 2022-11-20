# ChainSkills Truffle Box

This Truffle Box has all you need to create a DApp by following the course delivered by [ChainSkills](https://www.udemy.com/getting-started-with-ethereum-solidity-development/).

This box has been based from [pet-shop-box](https://github.com/truffle-box/pet-shop-box).

## Installation

1. Install Truffle globally.

   ```javascript
   npm install -g truffle
   ```

2. Download the box. This also takes care of installing the necessary dependencies.

   ```javascript
   truffle unbox chainskills/chainskills-box
   ```

3. Run the development console.

   ```javascript
   truffle migrate --compile-all --reset --network ganache
   truffle migrate --compile-all --reset --network chainskills
   truffle console --network ganache
   truffle console --network chainskills
   ```

4. Compile and migrate the smart contracts. Note inside the development console we don't preface commands with `truffle`.

   ```javascript
   compile
   migrate --network ganache
   ```

   Check the balance:

   -  ```
      web3.eth.getAccounts(function (err, acc) { accounts = acc;});
      ```

   -  ```
      var balance = async (index) => { return web3.utils.fromWei( await web3.eth.getBalance(accounts[index]), "ether");};
      ```
   -  ```
       ChainList.deployed().then(function(instance){app = instance;})
      ```

   -  ```
      app.sellArticle("IPhone 7","Selling in order to buy IP8",web3.utils.toWei("3","ether"),{from: accounts[1]})
      ```

   -  ```
      app.buyArticle({from:accounts[2], value:web3.utils.toWei("3","ether")})
      ```

5. Run the `liteserver` development server (outside the development console) for front-end hot reloading. Smart contract changes must be manually recompiled and migrated.
   ```javascript
   // Serves the front-end on http://localhost:3000
   npm run dev
   ```

## Testing

Chay test

```javascript
   truffle test --network ganache

```

## Private Node

Unloack account

```javascript
web3.eth.personal.unlockAccount(accounts[1], "pass1234", 600);
```
