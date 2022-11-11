// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

library Mapping {
    
    function Add(mapping(address => uint256) storage _map, address _account, uint256 _money) external {
        _map[_account] += _money;
    }

    function Sub(mapping(address => uint256) storage _map, address _account, uint256 _money) external {
        require(_map[_account] - _money > 0, "negative balance");
        _map[_account] -= _money;
    }
}

contract AccessControl{
	mapping(address => bool) owners;
    mapping(address => uint) ownerCandidates;

    mapping(address => mapping(address => bool)) isVoted;
	mapping(address => bool) users;

    address owner;
    uint ownerCount = 0;

    event OwnerAdded(
        address indexed newOwner
    );

    event UserAdded(
        address indexed newUser
    );

    event UserRemoved(
        address indexed User
    );
	
    modifier onlyOwner {
        // owner 만 가능
        require(owners[msg.sender], "Only Owner~");
        _;
    }
	
	modifier onlyUser{
		// user & owner 만 가능
        require(users[msg.sender] || owners[msg.sender], "Only User~");
        _;
	}
	
	constructor() payable{
        owner = msg.sender;
    }
	
	function AddUser(address Address) public onlyOwner{
		require(Address != address(0));
        users[Address] = true;
        emit UserAdded(Address);
	}
	
    function removeUser(address Address) public onlyOwner{
        require(Address != address(0));
        users[Address] = false;
        emit UserRemoved(Address);
	}

    function addOwnerCandidates(address Address) public onlyOwner{
        require(Address != address(0));
        ownerCandidates[Address] = 0;

        if(ownerCandidates[Address] >= 2 * ownerCount / 3)
        {
            owners[Address] = true;
            ownerCount ++;
        }
    }

    function voteToCandidates(address Address, bool Vote) public onlyOwner{
        require(isVoted[owner][Address] == false);
        
        if(Vote == true){
            ownerCandidates[Address]++;
        }

        if(ownerCandidates[Address] >= 2 * ownerCount / 3)
        {
            owners[Address] = true;
        }
    }
}

contract Bank is AccessControl{
    
    using Mapping for mapping(address => uint256);

    event CheckMoney(address owner,uint256 balance);

    mapping(address => uint256) public balance;
    
    function sendMoney() external payable onlyUser{
        balance.Add(owner, msg.value);
        emit CheckMoney(owner, balance[owner]);
    }

    function drawMoney(uint256 _withdrawMoney) external payable onlyUser{
        balance.Sub(owner, _withdrawMoney);
        (bool success,) = owner.call{value:_withdrawMoney}("");
        require(success, "failed");
        emit CheckMoney(owner, balance[owner]);
    }
    
   
    function Bankrupcy() external onlyOwner{
        (bool success,) = msg.sender.call{value: address(this).balance}("");
        require(success, "failed");
    }
}