//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract sample
{
   
    bytes32 public random1;
    bytes32 public random2;
    bytes32 public random3;
    bytes32 public ssid;
    bytes32 public bhash;
    uint256 public tmsp;

     function generateRandom(string memory str1,string memory str2,string memory str3) public
    {

        random1 =keccak256(abi.encodePacked(str1));
        random2 = keccak256(abi.encodePacked(str2));
        random3 = keccak256(abi.encodePacked(str3));
        bytes32 random=random1^random2;
        random=random^random3;
        ssid = (keccak256(abi.encodePacked(random)));
        bhash=blockhash(0);
        tmsp=block.timestamp;
    }
  
}