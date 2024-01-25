// SPDX-License-Identifier: MIT
pragma solidity >=0.5.5 < 0.9.0;

contract A{
    address public ownerA;
    constructor(){
        ownerA = msg.sender;
    }
}

contract Creator{
    address public ownerCreator;
    A[] public deployedA;

    constructor(){
        ownerCreator = msg.sender;
    }

    function deployeA() public {
        A new_A_address = new A();
        deployedA.push(new_A_address);
    }
}
