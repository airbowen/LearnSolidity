pragma solidity >=0.6.0 <0.9.0;

contract CrowdFunding{
    mapping (address => uint) public contributors;
    address public admin;
    uint public noOfContributors;
    uint public minimuncontributon;
    uint public deadline;
    uint public goal;
    uint public raisedAmount;

    constructor(uint _goal,uint _deadline){
        goal = _goal;
        deadline = block.timestamp + deadline;
        minimuncontributon = 100 wei;
        admin = msg.sender;
    }

    function contribute() public payable {
        require(block.timestamp < deadline,"deadline has passed");
        require(msg.value >= minimuncontributon);

        if (contributors[msg.sender] ==0){
            noOfContributors++;
        }
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }
    receive() external payable { 
        contribute();
    }
}
