pragma solidity ^0.4.17;

contract WhatRocks {

  // Ether supply associated with each brand address
  mapping(address => uint256) charityEthSupply;
  // Token ledger associated with each brand address
  mapping(address => mapping (address => uint256)) charityToken;
  // Token supply associated with each brand address
  mapping(address => uint) charityTokenSupply;
  // Whitelists associated with each brand address
  mapping(address => mapping(address => bool)) whitelist;
  // List of all brand owners
  mapping(address => bool) brandOwners;
  // Variable for storing the owner of the contract
  address owner;

  function WhatRocks() public {
    // Sets the owner to us
    owner = msg.sender;
  }

  // Calls when the contract is sent ETH.
  function mint(uint tokenSupply) public payable {

    // Instantiates and sets all of the tokenSupply to be owned by brandOwner
    charityToken[msg.sender][msg.sender] = tokenSupply;

    // Sets the other variables for the instantiated token balances
    charityTokenSupply[msg.sender] = tokenSupply;
    charityEthSupply[msg.sender] = msg.value;
    brandOwners[msg.sender] = true;

  }

  //Allows the brandOwner to distribute tokens to a certain address
  function distribute (address to, uint256 tokens, address brandOwner) public {
    // Only allows BrandOwner to send tokens; requires there to be enough tokens to send
    require(msg.sender == brandOwner);
    require(charityToken[brandOwner][msg.sender] >= tokens);

    // If it is, then update the ledger for the tokens
    charityToken[brandOwner][msg.sender] -= tokens;
    charityToken[brandOwner][to] += tokens;
  }

  //Allows consumers to transfer
  function transfer (address to, uint256 tokens, address brandOwner) public {
    // Checks whether or not there is actually the amount available in the address
    // Checks whether or not the address "to" is whitelisted
    require(whitelist[brandOwner][to] == true);
    require(charityToken[brandOwner][msg.sender] >= tokens);

    // If both are true, then update the ledger for the tokens
    charityToken[brandOwner][msg.sender] -= tokens;
    charityToken[brandOwner][to] += tokens;
  }

  function redeem (uint tokens, address brandOwner) public {
    // Checks whether or not the address is on the whitelist / is a charity
    require(whitelist[brandOwner][msg.sender] == true);

    // If it's on the whitelist then, update the token ledger - only subtract
    charityToken[brandOwner][msg.sender] -= tokens;

    // Transfer a certain amount of ETH to the address
    // Calculates the amount of ETH to transfer
    uint256 ethToTransfer = charityEthSupply[brandOwner] * tokens / charityTokenSupply[brandOwner];
    charityEthSupply[brandOwner] -= ethToTransfer;
    msg.sender.transfer(ethToTransfer);
  }

  //Add an entry to the
  function addToWhitelist (address addr, address brandOwner) public {
    require(msg.sender == brandOwner);
    whitelist[brandOwner][addr] = true;
  }

}
