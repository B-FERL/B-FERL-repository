pragma solidity ^0.6.0;

interface challenge
{
    function bhash() external view returns(bytes32);
    function random1() external view returns(bytes32);
    function random2() external view returns(bytes32);
    function random3() external view returns(bytes32);
    function ssid() external view returns(bytes32);
}

contract challenge_response 
{
    bytes32 public r1;
    bytes32 public r2;
    bytes32 public r3;
    bytes32 public sid;
    bytes32 public _bhash;
    uint256 public _tmsp;
    bool cav_verf=false;
    bool ecu_verf=false;
    bool public res=false;
    address addr;
    function setaddr(address _addr) public payable
    {
        addr=_addr;
    }
    function get(uint i,string memory _str1,string memory _str2,string memory _str3) public  
    {
        _bhash=blockhash(i);
        r1 =keccak256(abi.encodePacked(_str1));
        r2 = keccak256(abi.encodePacked(_str2));
        r3 = keccak256(abi.encodePacked(_str3));
        bytes32 random=r1^r2;
        random=random^r3;
        sid = (keccak256(abi.encodePacked(random)));
        _tmsp=block.timestamp;
    }
    function cav_check() public 
    {

       if(_bhash==challenge(addr).bhash())
       {
         cav_verf=true;
         if(sid==challenge(addr).ssid())
         {
             res=true;
         }
         uint randnum= uint(keccak256(abi.encodePacked(now,msg.sender,uint(0)))) %3;
         if(randnum==0){
             if(r1==challenge(addr).random1()){
                 ecu_verf=true;
             }
         }
         else if(randnum==1)
         {
             if(r2==challenge(addr).random2())ecu_verf=true;
         }
         else
         {
             if(r3==challenge(addr).random3())ecu_verf=true;
         }
       }
       
    }
    
}