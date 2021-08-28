 pragma solidity ^0.8.0;
//"SPDX-License-Identifier: UNLICENSED"
import "/home/ahmad/Truffle/openzaperc20/node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "/home/ahmad/Truffle/openzaperc20/node_modules/openzeppelin-solidity/contracts/access/Ownable.sol";
contract erctoken is Ownable , ERC20 {
    
    address public ownerof;
    uint private rate;
    uint private supply;
    uint private tokenCap = 2000000 * 100 ** 18;
    uint private contractdeploytime;
    uint public constant DELAY = 1 minutes;
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
}
