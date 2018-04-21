pragma solidity ^0.4.17;

contract WhatRocks {

  // Ether supply in contract, associated with each brand
  mapping(address => uint256) charityFund;
  mapping(address => uint256) balances;
  mapping(address => bool) whitelist;
  uint charityTokenSupply;
  address brandOwner;
  address owner;

  function WhatRocks() public {
    owner = msg.sender;
  }

  // Calls when the contract is sent ETH.
  function mint(uint tokenSupply) public payable {
    require(charityTokenSupply == 0);
    // Set the brandOwner to the person who calls the address
    brandOwner = msg.sender;

    // Stores the amount of ETH associated with each brand address
    charityFund[msg.sender] = msg.value;

    // Sets the other variables for the instantiated token balances
    charityTokenSupply = tokenSupply;

    // Set all of the tokenSupply to be owned by brandOwner
    balances[msg.sender] = tokenSupply;
  }

  //Allows the brandOwner to distribute tokens to a certain address
  function distribute (address to, uint256 tokens) public {
    // Require msg.sender to be the
    // Require there to be enough
    require(msg.sender == brandOwner);
    require(balances[msg.sender] >= tokens);

    // If it is, then send the recipient
    balances[msg.sender] -= tokens;
    balances[to] += tokens;
  }

  //Allows consumers to transfer
  function transfer (address to, uint256 tokens) public {
    // Checks whether or not there is actually the amount available in the address
    // Checks whether or not the address "to" is whitelisted
    require(whitelist[to] == true);
    require(balances[msg.sender] >= tokens);

    // If both are true, transfer the
    balances[msg.sender] -= tokens;
    balances[to] += tokens;
  }

  function redeem (uint tokens) public {
    // Checks whether or not the address is on the whitelist
    require(whitelist[msg.sender] == true);

    // If it's on the whitelist then...
    // Decrease the amount of tokens on the mapping by the amount - do we need to destroy or does it not matter?
    balances[msg.sender] -= tokens;

    // Transfer a certain amount of ETH to the address
    // Transfer the tokens to a 00x address
    uint256 ethToTransfer = tokens/charityTokenSupply;
    charityFund[brandOwner] -= ethToTransfer;
    msg.sender.transfer(ethToTransfer);
  }

  //Add an entry to the
  function addToWhitelist (address addr) public {
    require(msg.sender == brandOwner);
    whitelist[addr] = true;
  }



}
