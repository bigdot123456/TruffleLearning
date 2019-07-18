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

 
 
