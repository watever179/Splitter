pragma solidity ^0.5.0;

import './SafeMath.sol';
import './Pausable.sol';

contract Splitter is Pausable{
    
        using SafeMath for uint;
        
        mapping(address => uint) private balances;
            
        constructor(bool isContractRunning)  public Pausable(isContractRunning)  {
                  
         }
              
        event SplitEvent( address indexed alice,  uint amount,address indexed bob,address indexed carol );
        event WithdrawlEvent(  address indexed receiver,uint amount );
        event FundsSent(address receiver, uint amount, string message);

    // this function is used to check balance
    function getBalanceOf(address _address)  public view returns(uint balance)  {
        balance = balances[_address];
    }
    
    //Split funds , only Alice can Split the funds which is a contract owner
     function split( address payable bob, address payable carol )public payable runningOnly ownerOnly {
        require(bob != address(0x0) && carol != address(0x0));
        //divide amount into half
        require(msg.value>0, "Specify Amount needs to be splitted");
        uint halfofTheAmount = msg.value.div(2);
        // record balances
        balances[bob] = balances[bob].add(halfofTheAmount);
        balances[carol] = balances[carol].add(halfofTheAmount);

        // emit event
        emit SplitEvent(msg.sender, msg.value, bob, carol);
        
        // odd number, returning the change.
        if(msg.value.mod(2) > 0) msg.sender.transfer(1);
    }
        
      function sendFunds(address payable receiver, uint amount) private runningOnly {
        require(amount>0,"Please Specify Amount other than 0") ;
        receiver.transfer(amount);
        emit FundsSent(receiver, amount, "Funds has been transferred to receiver");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[receiver] = balances[receiver].add(amount);
    }    

}
