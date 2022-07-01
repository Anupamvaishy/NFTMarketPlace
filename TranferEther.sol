// SPDX-License-Identifier: MIT
/** Create a small project using Solidity,
 in which cover constructor, 1 setter function and
  1 getter function and one send transaction function 
  which send the Ether from one address to another */
pragma solidity ^0.8.4;
contract task{
    address public manager;
    address  payable public  recipient;
    constructor()
    {
        manager=msg.sender;
    }
  
 function getter() public view returns(address payable)
    {
return  recipient;
    }
     function setter(address payable per)  payable external
    {
      recipient=per;
   }

    function sent(address payable  recipient) payable external{
          require(msg.value >= 1);
        recipient.transfer(msg.value);
   }


    

}