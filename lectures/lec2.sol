// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec2{
    //data type

    //boolean type
    bool public b = false;
    bool public b1 = !false; //true
    bool public b2 = false || true; //true
    bool public b3 = false == true; //false
    bool public b4 = false && true; //false
    
    //bytes
    bytes4 public bt = 0x12345678;
    bytes public bt2 = "STRING";

    //address
    address public addr = 0xD4Fc541236927E2EAf8F27606bD7309C1Fc2cbee;

    //int vs uint
    int8 public it=4;
    uint256 public uit = 132213;
    uint8 public uit2=255;
}