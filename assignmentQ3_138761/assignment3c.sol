pragma solidity ^0.8.0;
//"SPDX-License-Identifier: UNLICENSED"
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';
contract erctoken is Ownable , ERC20 {
    
    address public ownerof;
    uint private rate;
    uint private supply;
    uint private tokenCap = 2000000 * 100 ** 18;
    uint private contractdeploytime;
    uint public constant DELAY = 1 minutes;
     mapping(address => bool) private priceApprovers;
    constructor() ERC20('mytoken','MYT'){
       
       _mint(msg.sender, 1000000 * 10 ** 18);
       rate = 100;
        ownerof = msg.sender;
    }
    
     function buyToken () payable external {
        require(ERC20.totalSupply() + msg.value <= tokenCap, "ERC20Capped: Token Cap exceeded");
        _mint(msg.sender, msg.value * rate * 10 ** 18);
        contractdeploytime =  block.timestamp;
     }
     
     fallback() external payable {
        if (msg.value > 0 ){
            _mint(msg.sender, msg.value * rate * 10 ** 18 );
        } 
        
     }
     
      function changerate(uint amount) external {
        require(msg.sender == ownerof , "only owner can change the rate");
        rate = amount;
        
    }     
    
     function cap() public view virtual returns (uint256) {
        return tokenCap;
     }
     
     function transfer_with_Delay(address recipient, uint256 amount) public virtual {
        require(block.timestamp >= contractdeploytime + DELAY, "dealy time");
        _transfer(_msgSender(), recipient, amount);
    }
    
    function tokenrefund(uint _token)external {
    uint value;
    require(_token <= balanceOf(msg.sender), "Insufficient Balance for Withdrawl of tokens");
    value = _token/rate;
    transfer(owner(), _token);
    payable(msg.sender).transfer(value);
    
    }
    modifier priceAppr() { 
        require(priceApprovers[msg.sender], "Either Owner or Approver can call this function");
        _; 
        
    }
    function delegatePriceApproval(address _approver) external onlyOwner {
        priceApprovers[_approver] = true;
    }
    function revokePriceApproval(address _approver) external onlyOwner {
        require(priceApprovers[_approver], "The user doesn't exist or already been revoked");
        priceApprovers[_approver] = false;
    }
}
