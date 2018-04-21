pragma solidity ^0.4.17;

contract WhatRocks {
  //Variables in storage required
  address public brandOwner;
  XX XX whitelist;

  //Calls when the contract is sent ETH.
  function mint(tokenSupply) {
    //Takes the ETH and stores it in the address?

    //Stores the address of the creator
    brandOwner = msg.sender;
    //instantiates the mapping for the token
    mapping(address => uint256) balances;
    // Associates the mapping to the brandOwner address?

    // Mechanism for increasing supply based on ETH
    //Generate all of the tokens and assign them to the brandOwner
    balances[brandOwner] =

  }

  //Allows the brandOwner to distribute tokens to a certain address
  function distribute (address to, uint tokens) {
    // Require msg.sender to be the brandOwner
    // Require there to be enough

    // If it is, then send the recipient
    balances[msg.sender] = balances[msg.sender].sub(tokens);
    balances[to] = balances[to].add(tokens);
    Trasnfer(msg.sender, to, tokens);
  }

  //Allows
  function transfer (address to, uint tokens) {
    // Checks whether or not there is actually the amount available in the address
    // Checks whether or not the address "to" is whitelisted

    // If both are true, transfer the
    balances[msg.sender] = balances[msg.sender].sub(tokens);
    balances[to] = balances[to].add(tokens);
    Trasnfer(msg.sender, to, tokens);

  }

  function redeem (amount) {
    // Checks whether or not the address is on the whitelist

    // If it's on the whitelist then...

    // Decrease the amount of tokens on the mapping by the amount - do we need to destroy or does it not matter?

    // Transfer a certain amount of ETH to the address
    // Transfer the tokens to a 00x address


  }

  //Add an entry to the
  function addToWhitelist (charity_address) {

  }



}
