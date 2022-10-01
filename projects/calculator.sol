// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract Model{
    
    uint256 public ethereum_value;
    uint256 public exchange_value;
    uint256 public cash_value;

    constructor(uint256 _exchange_value){
        exchange_value = _exchange_value;
    }

    function getExchange(uint256 _exchange_value) public {
        exchange_value = _exchange_value;
    }
        
    function wei2ether(uint256 _value) public  {
        ethereum_value = (_value/10**18);
    }

    function ether2cash() public {
        cash_value = ethereum_value * exchange_value;
    }
}

contract Calculator{

    uint256 public Exchange_value=15;

    Model instance = new Model(Exchange_value);

    function getExchange(uint256 _exchange_value) public {
        Exchange_value = _exchange_value;
        instance = new Model(Exchange_value);
    }
  
    function wei2ether(uint256 _weivalue) public {
        instance.wei2ether(_weivalue);
    }

    function ether2cash() public {
        instance.ether2cash();
    }

    function getInfo() public view returns(uint256, uint256) {
        return (instance.ethereum_value(), instance.cash_value());
    }
}