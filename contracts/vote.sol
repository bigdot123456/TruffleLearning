pragma solidity >=0.4.0 <0.7.0;

// 必须指明编译这段代码的编译器版本
contract Voting {
  /* 下面这个 mapping 域相当于一个关联数组或哈希。
      mapping 的键是候选项的名字，类型为 bytes32；
      值的类型是无符号整型，用于存储得票数。
  */
  mapping (bytes32 => uint8) public votesReceived;
  /* Solidity（还）不允许给构造器传入字符串数组。
  所以我们用 bytes32 数组存储候选项
  */
  bytes32[] public candidateList;
  /* 这就是把合约部署到区块链上时会执行一次的构造器。
  在部署合约时，我们会传入一个包含候选项的数组。
  */
  // function Voting(bytes32[] candidateNames) public {
  constructor (bytes32[] memory candidateNames) public { 
    candidateList = candidateNames;
  }
  // 这个函数用于返回指定候选项的总票数，其参数即为指定候选项
  function totalVotesFor(bytes32 candidate) view public returns (uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }
  // 这个函数用于将指定候选项的票数加一
  // 这相当于实现了投票功能
  function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }
  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
}
