// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract Aduction{
    address payable  public owner;
    uint public startBlock;
    uint public endBlock;
    uint public   highestBindingBid;

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

    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }
    modifier afterStart(){
        require(msg.sender != owner);
        _;
    }
    modifier beforeEnd(){
        require(msg.sender != owner);
        _;
    }
    modifier onlyOwner(){
        require (msg.sender == owner);
        _;
    }
    function min(uint a,uint b) pure internal  returns(uint){
        if(a <= b){
            return a;
        }else{
            return b;
        }
    }
    function cancelAuction() public onlyOwner{
        auctionState = State.Canceled;
    }
    
    function placeBid() public payable notOwner beforeEnd afterStart{
        require(auctionState == State.Running);
        require( msg.value >= 100);

        uint currentBid = bids[msg.sender] + msg.value;
        require(currentBid >higherBindingBid);

        bids[msg.sender] = currentBid;
        if (currentBid <= bids[higherBindder]){
            highestBindingBid = min(currentBid+bidIncrement,bids[higherBindder]);
        }else{
           highestBindingBid = min(currentBid,bids[ higherBindder]+bidIncrement);
           higherBindder = payable (msg.sender);
        }
    }
}