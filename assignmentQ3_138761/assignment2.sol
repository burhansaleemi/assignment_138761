pragma solidity ^0.8.0;

contract CyrptoBank {
    
    address payable owner;
    uint public bankCapital;
    event banklog(string);
    mapping(address => uint) accountBalance;
    
        
    
    constructor() payable {
        
        require(msg.value >= 50 ether , "Send 50_ETH to become owner");
        owner = payable(msg.sender);
        bankCapital = msg.value;
        emit banklog("50_ETH is added by the owner");
        
        }
        
    modifier onlyowner (address _owner) {
        
        require (_owner == owner, "only owner can closebank");
         _;
    }
        
    function closebank() payable public onlyowner(msg.sender) {
        
        selfdestruct(owner);
        emit banklog("Bank closed");
        
    }

    function openAccount()payable public {
    
    accountBalance[msg.sender] = accountBalance[msg.sender] + msg.value;
    emit banklog("Account created");
    
    }
    
    function depositmoney(address _account) payable public {
        accountBalance[_account]+=msg.value;
        emit banklog("Account is upadated");
    }
    
    function withdraw(uint _amount) payable public {
        require(accountBalance[msg.sender]>= _amount , "blance is less then command");
        accountBalance[msg.sender]-=_amount;
        payable(msg.sender).transfer(_amount);
        emit banklog("withdraw successful");
        
        
    }
    
    
    function checkbalance(address _address ) public view returns (uint _balance){
        
        return accountBalance[_address];
    }
    
    function closeAccount() payable public{
        require(accountBalance[msg.sender] > 0 , "account is null" );
        payable(msg.sender).transfer(accountBalance[msg.sender]);
        emit banklog("Account closed");
    }
        
    }
    
