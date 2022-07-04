// SPDX-License-Identifier: MIT
/** Create a small project using Solidity,
 in which cover constructor, 1 setter function and
  1 getter function and one send transaction function 
  which send the Ether from one address to another */
pragma solidity ^0.8.4;
contract task{
    address public Deployer;//This datatype is use for storing the address of deployer
    address payable public recipient;//This  datatype is use for recieve payment.
    address payable public setAddressOfReciever;//This datatype is use for setting address of recipient.

 constructor()//this constructor is used for restore the address of deployer
    {
        Deployer=msg.sender;
    }
  
 function getter() public view returns(address payable)//This getter function is used for return the address of reciever
    {
        return  setAddressOfReciever;
    }
function setter(address payable recipient)  payable external// This setter function is used for set the address of reciever.
    {
        setAddressOfReciever=recipient;//In this line Address of recipient stored in setAddressOfReciever
    }

function sent(address payable  recipient) payable external//This function is used for sent payment from one account to another
    {
        require(msg.value >= 1);//This line ensure that there will be tranfer ether is equals or more that one with the help of require function.
        recipient.transfer(msg.value);//This line give address of recipient in which we want to sent payment.  
   }
}