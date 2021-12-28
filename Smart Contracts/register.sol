//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract register
{
   
    uint256 id;
    bytes32 private ecu1;
    bytes32 private ecu2;
    bytes32 private ecu3;
    bytes32 private ssid;
    uint256 private tmsp;
    function generate (string memory str1,string memory str2,string memory str3,uint256 n) public
    {
        id=n;
        ecu1 =keccak256(abi.encodePacked(str1));
        ecu2 = keccak256(abi.encodePacked(str2));
        ecu3 = keccak256(abi.encodePacked(str3));
        bytes32 random=ecu1^ecu2;
        random=random^ecu3;
        ssid = (keccak256(abi.encodePacked(random)));
        tmsp=block.timestamp;
    }
    function retrieve()public view returns(bytes32)
    {
        return ssid;
    }
    function ret_ecu1() public view returns(bytes32)
    {
        return ecu1;
    }
    function ret_ecu2() public view returns(bytes32)
    {
        return ecu2;
    }
    function ret_ecu3() public view returns(bytes32)
    {
        return ecu3;
    }
    function ret_tmsp() public view returns(uint256)
    {
        return tmsp;
    }
    function ret_ssid() public view returns(bytes32)
    {
        return ssid;
    }
    function update_tmsp(uint256 t) public
    {
        tmsp=t;
    }
    function update_cav(bytes32 e1,bytes32 e2,bytes32 e3,bytes32 sid,uint time) public
    {
        ecu1=e1;
        ecu2=e2;ecu3=e3;
        ssid=sid;
        tmsp=time;
    }
}
