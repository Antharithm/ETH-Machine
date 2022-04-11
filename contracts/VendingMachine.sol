// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract VendingMachine {
    address public owner;

    // donut balance mapping
    mapping (address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    // balance of vending machine
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    // restock the vending machine
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] += amount; // add donuts
    }

    // buy a donut
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1 ether, "You must pay at least 1 ether per donut"); // price of a donut
        require(donutBalances[address(this)] >= amount, "not enough donuts in stock");
        donutBalances[address(this)] -= amount; // subtrack donuts
        donutBalances[msg.sender] += amount; // update the amount of donuts
    }
}