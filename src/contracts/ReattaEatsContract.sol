// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;


contract ReattaEatsContract {

  address owner;
  uint256 public menuCount = 0;
  mapping(uint => Menu) public menus;

  struct Menu {
    uint id;
    string image_hash;
    string description;
    string price;
  }



  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function addMenu (string memory _imageHash, string memory _desc, string memory price) public onlyOwner{
    menuCount ++;
    menus[menuCount] = Menu(menuCount, _imageHash, _desc, price);
  }

  // if call of isOwner, enable the component of adding menu 
  function isOwner() public view returns(bool) {
    return (msg.sender == owner);
  }
  
}
