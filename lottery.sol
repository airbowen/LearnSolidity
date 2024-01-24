// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract Lottery{
    address payable[] public playes;
    address public manager;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value == 0.1 ether );
        playes.push(payable(msg.sender));
     }

     function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
     }

     function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,playes.length)));
     }
     function pickWinner() public {
        require(msg.sender == manager);
        require(playes.length >= 3);

        uint r = random();
        address payable winner;

        uint index = r % playes.length;
        winner = playes[index];
        
        winner.transfer(getBalance());
        playes = new address payable[](0);

     }
}