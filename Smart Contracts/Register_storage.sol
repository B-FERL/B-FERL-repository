//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;
import "./register.sol";

contract Register_storage
{
    register[] public CAV;
    uint256 n=uint(-1);
    string st1;
    string st2;
    string st3;
    function create() public
    {
        n=n+1;
        register s=new register();
        CAV.push(s);store();
    }
    function get(string memory s1,string memory s2,string memory s3) public
    {
        st1=s1;
        st2=s2;
        st3=s3;
    }
    function store() internal
    {
        register R=register(address(CAV[n]));
        R.generate(st1,st2,st3,n);
    }

    function get_n() external view returns(uint256)
    {
        return n;
    }
    function get_ecu1(uint id) external view returns(bytes32)
    {
         register R=register(address(CAV[id]));
         return R.ret_ecu1();
    }
     function get_ecu2(uint id) external view returns(bytes32)
    {
         register R=register(address(CAV[id]));
         return R.ret_ecu2();
    }
     function get_ecu3(uint id) external view returns(bytes32)
    {
         register R=register(address(CAV[id]));
         return R.ret_ecu3();
    }
     function get_time(uint id) external view returns(uint)
    {
         register R=register(address(CAV[id]));
         return R.ret_tmsp();
    }
    function get_ssid(uint id) external view returns(bytes32)
    {
        register R=register(address(CAV[id]));
         return R.ret_ssid();
    }
    function time_update(uint id,uint time) external payable
    {
         register R=register(address(CAV[id]));
         R.update_tmsp(time);
    }
    function manage(uint i,bytes32 e1,bytes32 e2,bytes32 e3,bytes32 sid,uint time) external payable
    {
         register R=register(address(CAV[i]));
         R.update_cav(e1,e2,e3,sid,time);
    }
}
