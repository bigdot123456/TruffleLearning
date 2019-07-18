# Create truffle learning

** first create github script! create a new repository on the command line

```shell

echo "# TruffleLearning" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/bigdot123456/TruffleLearning.git
git push -u origin master
```
** second use truffle command to migrate contract

```shell
truffle init
truffle compile
truffle migrate
```


## Error correction


* error1
Data location must be "memory" for parameter in function, but none was given.
  constructor (bytes32[] candidateNames) public {
               ^----------------------^

Compilation failed. See above.
    at Object.compile (/Users/liqinghua/git/nvm/versions/node/v12.6.0/lib/node_modules/truffle/build/webpack:/packages/truffle-workflow-compile/index.js:103:1)

first answer
```
Explicit data location for all variables of struct, array or mapping types is now mandatory. This is also applied to function parameters and return variables.

Add memory after string

function setmeme(string memory _url, string memory _name, uint _timestamp) public{
check here for Solidity 0.5.0. changes https://solidity.readthedocs.io/en/v0.5.0/050-breaking-changes.html
```

* error2

pure限制词
Function state mutability can be restricted to pure。 -> 功能状态可变性可以限制为pure

在之前的版本中我们经常使用constant来限制一个方法的制度性，当用constant修饰之后，此方法在被调用时不会进行存储的变更，同样不会产生交易和gas花费。而pure正是constant的替代品，逐渐的在替代constant的功能。

修改后代码如下：


```javascript
pragma solidity ^0.5.2;        // 指定所需的编译器版本

contract clac{                 
        function multiply(uint a, uint b) public pure returns (uint){
                return a + b;
        }
}
```

 
## including zepplinos project 

This tutorial will get you started using ZeppelinOS. We will create a new project with a simple contract, deploy it to a development network, interact with it from the terminal, and then upgrade it.

Prerequisites
ZeppelinOS is bundled as an npm package. We will need node.js to install and run it. Head over to its website for instructions on how to install it.

Note: At the moment, ZeppelinOS does not support node 12. Make sure to install version 10.

Once you have installed node, you can install the ZeppelinOS CLI:

npm install --global zos
Note: We are installing the CLI globally in our workstation. Alternatively, you can install it locally to each project by running npm install --save-dev zos in your project folder. This would require you to run every command by prefixing it with npx. Installing it locally allows you to have different zos versions in different projects, but it requires you to reinstall every time you start a new project.

Setting up your project
We'll first create a node.js project in a new directory. Head over to a terminal and run:

mkdir my-project
cd my-project
npm init -y
Let's now use the CLI to initialize a ZeppelinOS project:

zos init
The CLI will prompt you to choose a project name and version, defaulting to the ones from the package.json, and then it will set up a few files and folders for running your ZeppelinOS project.

We are now ready to begin coding.

Note: Should you get lost at any point during this tutorial, you can refer to the full code for this project in our Github repo.

Your first contract
We will write a simple contract in Solidity, the most popular language for Ethereum smart contracts. Create a new file contracts/Counter.sol in your project with the following content:

pragma solidity ^0.5.0;

contract Counter {
  uint256 public value;
  
  function increase() public {
    value++;
  }
}
This contract will just keep a numeric value that will be increased by one every time we send a transaction to the increase() function.

You can run zos compile to compile the contract and check for any errors. After it is compiled successfully, we can deploy our contract.

Note: You don't have to worry if you forget to compile your contract. The CLI will automatically check if your contract changed when you run any command and compile it if needed.

Deploying to a development network
We will use ganache as a development network to deploy our contract. If you don't have ganache installed, do so now by running npm install -g ganache-cli.

Development networks are mini blockchains that run just on your computer and are much faster than the actual Ethereum network. We will use one for coding and testing.

Open a separate terminal, and start a new ganache process:

ganache-cli --deterministic
This will start a new development network using a deterministic set of accounts instead of random ones. We can now deploy our contract there, running zos create, and choosing to deploy the Counter contract to the development network.

$ zos create
✓ Compiled contracts with solc 0.5.9 (commit.e560f70d)
? Pick a contract to instantiate: Counter
? Pick a network: development
✓ Added contract Counter
✓ Contract Counter deployed
? Do you want to call a function on the instance after creating it?: No
✓ Setting everything up to create contract instances
✓ Instance created at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601
Note: The addresses where your contracts are created, or the transaction identifiers you see, may differ from the ones listed here.

Our counter contract is deployed to the local development network and ready to go! We can test it out by interacting with it from the terminal. Let's try incrementing the counter by sending a transaction to call the increase function through zos send-tx.

$ zos send-tx
? Pick a network: development
? Pick an instance: Counter at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601
? Select which function: increase()
✓ Transaction successful. Transaction hash: 0x20bef6583ea32cc57fe179e34dd57a5494db3c403e441624e56a886898cb52bd
We can now use zos call to query the contract's public value and check that it was indeed increased from zero to one.

$ zos call
? Pick a network: development
? Pick an instance: Counter at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601
? Select which function: value()
✓ Method 'value()' returned: 1
Upgrading your contract
We will now modify our Counter contract to make the increase function more interesting. Instead of increasing the counter by one, we will allow the caller to increase the counter by any value. Let's modify the code in contracts/Counter.sol to the following:

pragma solidity ^0.5.0;

contract Counter {
  uint256 public value;
  
  function increase(uint256 amount) public {
    value += amount;
  }
}
We can now upgrade the instance we created earlier to this new version:

$ zos upgrade
? Pick a network: development
✓ Compiled contracts with solc 0.5.9 (commit.e560f70d)
✓ Contract Counter deployed
? Which proxies would you like to upgrade?: All proxies
Instance upgraded at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601.
Done! Our Counter instance has been upgraded to the latest version, and neither its address nor its state has changed. Let's check it out by increasing the counter by ten, which should yield eleven, since we had already increased it by one:

$ zos send-tx
? Pick a network: development
? Pick an instance: Counter at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601
? Select which function: increase(amount: uint256)
? amount (uint256): 10
Transaction successful: 0x9c84faf32a87a33f517b424518712f1dc5ba0bdac4eae3a67ca80a393c555ece

$ zos call
? Pick a network: development
? Pick an instance: Counter at 0xCfEB869F69431e42cdB54A4F4f105C19C080A601
? Select which function: value()
Returned "11"
Note: If you are curious about how ZeppelinOS achieves this feat, given that smart contracts are immutable, check out our upgrades pattern guide. You will see that there are some changes that are not supported during upgrades. For instance, you cannot remove or change the type of a contract state variable. However, you can change, add, or remove all the functions you want.

That's it! You now know how to start a simple ZeppelinOS project, create a contract, deploy it to a local network, and even upgrade it as you develop. Head over to the next tutorial to learn how to interact with your contract from your code. 
