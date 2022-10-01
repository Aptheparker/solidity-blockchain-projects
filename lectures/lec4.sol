// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec4{
    uint256 public a = 3;

    //no parameter and no return.
    function changeA1() public{
        a = 5;
    }
    //parameter and no return.
    function changeA2(uint256 _value) public{
        a = _value;

    }
    //parameter and return.
    function changeA3(uint256 _value) public returns(uint256){
        a=_value;
        return a;
    }
}