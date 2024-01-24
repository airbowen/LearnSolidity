// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract Aduction{
    address payable  public owner;
    uint public startBlock;
    uint public endBlock;

    string public ipfsHash;
    enum State {Started,Running,Ended,Canceled}
    State public auctionState;

    uint public higherBindingBid;
    address payable public higherBindder;

    mapping (address => uint) public bids;
    uint bidIncrement;

    constructor(){
        owner = payable(msg.sender);
        auctionState = State.Running;
        startBlock = block.number;
        endBlock = startBlock + 40320;
        ipfsHash = "";
        bidIncrement = 100;
    }
}