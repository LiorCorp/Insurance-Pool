pragma solidity >=0.4.25 <0.6.0;

contract Owned {
     address public owner;

     constructor() public {
         owner = msg.sender;
     }

     modifier onlyOwner {
         require(msg.sender == owner);
         _;
     }

     function transferOwnership(address newOwner) public onlyOwner {
         require(newOwner != address(0));
         owner = newOwner;
     }
}
