//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract register
{
   
    uint256 id; // CAV id
    //Firmware Hashes of ECUs 
    bytes32 private ecu1; 
    bytes32 private ecu2;
    bytes32 private ecu3;
    bytes32 private ssid; // Merkle tree root
    uint256 private tmsp; // Timestamp

        // Generating ECU hashes from given strings
    function generate (string memory str1,string memory str2,string memory str3,uint256 n) public
    {
        id=n;
         // Hashing the strings
        ecu1 =keccak256(abi.encodePacked(str1));
        ecu2 = keccak256(abi.encodePacked(str2));
        ecu3 = keccak256(abi.encodePacked(str3));
        bytes32 random=ecu1^ecu2;
        random=random^ecu3;
        ssid = (keccak256(abi.encodePacked(random)));
        tmsp=block.timestamp;
    }


        // Returns the Hash of ECU1
    function ret_ecu1() public view returns(bytes32)
    {
        return ecu1;
    }

        // Returns the Hash of ECU2 
    function ret_ecu2() public view returns(bytes32)
    {
        return ecu2;
    }

        //Returns the Hash of ECU3
    function ret_ecu3() public view returns(bytes32)
    {
        return ecu3;
    }

            // Returns the timestamp of the block
    function ret_tmsp() public view returns(uint256)
    {
        return tmsp;
    }

        // Returns the Merkle tree root
    function ret_ssid() public view returns(bytes32)
    {
        return ssid;
    }

        // Updates the timestamp
    function update_tmsp(uint256 t) public
    {
        tmsp=t;
    }

        // updates the ECU states
    function update_cav(bytes32 e1,bytes32 e2,bytes32 e3,bytes32 sid,uint time) public
    {
        ecu1=e1;
        ecu2=e2;ecu3=e3;
        ssid=sid;
        tmsp=time;
    }
}
