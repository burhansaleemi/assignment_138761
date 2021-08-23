pragma solidity ^0.8.0;
//"SPDX-License-Identifier: UNLICENSED"
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract erctoken is ERC20 {
    
    address public owner;
    uint private rate;
    uint private supply;

    
    constructor() ERC20('mytoken','MYT'){
       
       _mint(msg.sender, 1000000 * 10 ** 18);
       rate = 100;
        owner = msg.sender;
    }
    
     function buyToken () payable external {
        _mint(msg.sender, msg.value * rate * 10 ** 18);
     }
     
     fallback() external payable {
        if (msg.value > 0 ){
            _mint(msg.sender, msg.value * rate * 10 ** 18 );
        } 
     }
     
      function changerate(uint amount) external {
        require(msg.sender == owner , "only owner can change the rate");
        rate = amount;
        
    }     
}
