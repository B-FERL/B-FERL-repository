//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

interface challenge
{
    function get_n() external view returns (uint256);
    function time_update(uint,uint) external;
    function get_ecu1(uint) external view returns(bytes32);
    function get_ecu2(uint) external view returns(bytes32);
    function get_ecu3(uint) external view returns(bytes32);
    function get_ssid(uint) external view returns(bytes32);
    function get_time(uint) external view returns(uint256);
}

contract challenge_response 
{
    bytes32 r1;
    bytes32 r2;
    bytes32 r3;
    bytes32 sid;
    uint _id;
    uint256 _tmsp;
    bool public cav_verf=false;
    bool public ecu_verf=false;
    bool public res=false;
    address addr;uint flag=0;
     function get(uint i,string memory _str1,string memory _str2,string memory _str3) public  
    {
        _id=i;
        r1 =keccak256(abi.encodePacked(_str1));
        r2 = keccak256(abi.encodePacked(_str2));
        r3 = keccak256(abi.encodePacked(_str3));
        bytes32 random=r1^r2;
        random=random^r3;
        sid = (keccak256(abi.encodePacked(random)));
        _tmsp=block.timestamp;
    }
    function setaddr(address _addr) public payable
    {
        addr=_addr;
    }
   
   string public result;
   string public Security_attack;

    function cav_check() public payable
    {
        uint t=challenge(addr).get_n();
        uint time;
       if(_id<=t)
       {
        cav_verf=true;
         time=challenge(addr).get_time(_id);
         if(sid==challenge(addr).get_ssid(_id) && time<_tmsp)
         {
             res=true;
              uint randnum= uint(keccak256(abi.encodePacked(now,msg.sender,uint(0)))) %3;
             if(randnum==0){
                 if(r1==challenge(addr).get_ecu1(_id)){
                     ecu_verf=true;
                 }
             }
             else if(randnum==1)
             {
                 if(r2==challenge(addr).get_ecu2(_id))ecu_verf=true;
             }
             else
             {
                 if(r3==challenge(addr).get_ecu3(_id))ecu_verf=true;
             }
         }
         
       }
       if(res)
       {
          result="CAV is secure";
          Security_attack="None Found";
          challenge(addr).time_update(_id,now);
       }
       else
       {
           result="CAV is not secure";
           if(_id>t) Security_attack="Masquerade Attack (Fake CAV)";
           else if(sid!=challenge(addr).get_ssid(_id)) Security_attack="Code Injection";
           else if(time>=_tmsp) Security_attack="Reply Attack";
           else if(ecu_verf==false) Security_attack="ECU State Reversal Attack";
           else if(res==false) Security_attack="Fake Data";
       }

    }
    
    
}
