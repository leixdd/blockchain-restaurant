// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;


contract ReattaEatsContract {

  address owner;
  uint256 menuCount;
  mapping(uint256 => Menu) public menus;

  struct Menu {
    uint256 id;
    string image_hash;
    string description;
    uint256 price;
  }

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function addMenu (string memory _imageHash, string memory _desc, uint256 memory price) public onlyOwner {
    menuCount ++;
    menus[menuCount] = Menu(menuCount, _imageHash, _desc, price);
  }

}
