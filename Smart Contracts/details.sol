//SPDX-License-Identifier:MIT
pragma solidity 0.6.0;

contract Uppertier_details{
    uint[] details;
    uint public rno;
    bytes32 public id;uint n=uint(-1);
    
    function Create_id() public {
        n=n+1;
        rno=n;
        details.push(rno);     
        id=keccak256(abi.encodePacked(id));
    }
    function get_length() external view returns(uint)
    {
        return details.length;
    }
}
