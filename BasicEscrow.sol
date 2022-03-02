// SPDX-License-Identifier: MIT

pragma solidity 0.8.12;

contract BasicEscrow {

enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}

State public currentState;

address public buyer;
address payable public seller;

modifier onlyBuyer() {
  require(msg.sender == buyer, "only buyer can call this function");
  _;
}

constructor(address _buyer, address payable _seller) {
buyer = _buyer;
seller = _seller;
}

function deposit() onlyBuyer external payable {
require(currentState == State.AWAITING_PAYMENT, "already paid");
currentState = State.AWAITING_DELIVERY;
}

function confirmDelivery() onlyBuyer external {
require(currentState == State.AWAITING_DELIVERY, "delivery not confirmed");
seller.transfer(address(this).balance);
currentState = State.COMPLETE;
}
}