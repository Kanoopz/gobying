
//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { delegatorAccount } from "./delegatorAccount.sol";

contract Gobying
{
    address public governanceTokenAddress;


    mapping(address => address) public delegateeModules;
    mapping(address => address) public delegatorAccountAddresses;
    mapping(address => delegatorAccount) public delegatorAccounts;
    


    constructor(address paramGovernanceTokenAddress)
    {
        governanceTokenAddress = paramGovernanceTokenAddress;
    }

    function registerDelegateeModule(address paramDelegateeModule) public
    {
        delegateeModules[msg.sender] = paramDelegateeModule;
    }

    function createDelegatorAccount() public returns(address)
    {
        delegatorAccount newAccount = new delegatorAccount(msg.sender, governanceTokenAddress);
        delegatorAccounts[msg.sender] = newAccount;
        delegatorAccountAddresses[msg.sender] = newAccount.getAddress();

        return newAccount.getAddress();
    }

    function getDelegateeModuleAddress(address paramDelegateeAddress) public view returns(address)
    {
        return delegateeModules[paramDelegateeAddress];
    }

    function getDelegatorAccountAddress(address paramDelegatorAddress) public view returns(address)
    {
        return delegatorAccountAddresses[paramDelegatorAddress];
    }
}