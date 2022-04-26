pragma solidity ^0.8.4;

contract Wills {
    address owner;//to hold the address 
    uint paisa;
    bool margaya;//to check if died or not]

//payable: to send and receive ether
    constructor() payable public {
        owner = msg.sender;//msg  sender represents address that is being called 
        paisa = msg.value;//msg value tells us how much ether is being sent
        margaya = false;
    }
    // we create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    //we also create modifier so that we only allocate funds if friend's groups deceased
    modifier jaisemara {
        require(margaya == true);
        _;
    }
    //list or array of family wallets
    address payable[] fWallets;
//to know which address gets what value we use key store value in solidity by using a method
//called mapping
    mapping  (address => uint) santan;
    // now to set santan for each address using functions
    function setSantan(address payable wallet , uint amount) public onlyOwner {
        // to add wallets to the family wallets
        fWallets.push(wallet);
        santan[wallet] = amount;
    }

    //pay each family member based on wallet address

    function payout() private jaisemara {
        //with a for loop we can loop through things and set conditions
        for(uint i=0; i<fWallets.length; i++) {
            fWallets[i].transfer(santan[fWallets[i]]);
            //transfering the funds from contract address to receiver address
        }
    }
    //function to set ismargaya function to meet requirement margaya==true
    //oracle switch simulation
    function deceased() public onlyOwner {
        margaya = true;
        payout();
    }

}
