pragma solidity >=0.7.0 <0.9.0;

contract coin{
    
    //the keyword public is making the variables here accessible from other contracts

    address public minter;
    mapping (address => uint) public balances;

    event sent(address from , address to , uint amount);

    //constructor only runs when we deploy our constructor

    constructor() {
        minter = msg.sender;
    }

    //function to make new coin and send them to an address
    //only the owner can send these coins

    function mint(address receiver , uint amount ) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested , uint available);

    //function to send any amount of coins to existing address

    function send(address receiver , uint amount) public {
        if(amount > balances[msg.sender]){
            revert insufficientBalance({
                requested: amount, 
                available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender , receiver , amount);
    }
}