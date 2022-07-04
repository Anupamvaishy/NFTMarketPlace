// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.4;
 
 contract class
 {
     struct Student{
     string name;
     string cityName;   
 }
    
     mapping(uint=>Student) public data;
   
     function setter(uint _roll,string memory _name,string memory _cityName) public 
     {.
        data[_roll]=Student(_name,_cityName);
     }


 }
