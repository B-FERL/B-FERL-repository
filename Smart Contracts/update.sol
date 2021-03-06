//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

interface getdetails
{
    function get_length() external view returns(uint);
}

interface change
{
     function get_n() external view returns(uint256);
     function manage(uint i,bytes32 e1,bytes32 e2,bytes32 e3,bytes32 sid,uint time) external ;
     
}

contract update
{
    address addr;
    address cav_addr;
    function get_cavaddr(address a) public 
    {
        cav_addr=a;
    }
    function get_detailaddr(address a) public
    {
        addr=a;
    }
     string public message;
     function cav_update(uint r,uint cav_id,string memory e1,string memory e2,string memory e3) public payable 
    {
        uint n=getdetails(addr).get_length();
        if(r<n)
        {
            uint size=change(cav_addr).get_n();
            if(cav_id<=size)
            {
              bytes32 h1=keccak256(abi.encodePacked(e1));
              bytes32 h2=keccak256(abi.encodePacked(e2));
              bytes32 h3=keccak256(abi.encodePacked(e3));
              bytes32 con=h1^h2;
              con=con^h3;
              bytes32 sid=keccak256(abi.encodePacked(con));
              uint _id=cav_id;
              change(cav_addr).manage(_id,h1,h2,h3,sid,now);
              message="Block updated sucessfully!!";
            }
            else message="Invalid CAV ID!!!";
        }
        else message="Invalid USER ID!!!";
    }
}
