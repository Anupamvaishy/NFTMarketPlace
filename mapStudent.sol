// SPDX-License-Identifier: MIT.
//SPDX License Identifiers can be used to indicate relevant license information at any level, from package to the source code file level
 pragma solidity ^0.8.4;//This helps the code from being incompatible with the future versions of the compiler which may bring changes.
 
 contract class
 {
     struct Student{
     string name;
     string cityName;   
 }
    
     mapping(uint=>Student) public details;//mapping key and value together 
    function setDetails(uint _rollNo,string memory _name,string memory _cityName) public//this function setdetails use three argument.
     {
        details[_rollNo]=Student(_name,_cityName);//set data in details in which _rollNo use as a key and Student(_name,_cityName) as a value.
     }


 }
