//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface iGovernanceToken
{
    function delegate(address delegatee) external;
    function balanceOf(address account) external view returns(uint256);
    function delegates(address account) external view returns(address);
}

contract baseModule
{
    address delegateeOwner;
    string public proposal;
    address public opTokenAddress;


    mapping(address => uint256) public actualDelegatorDelegationQuantity;
    mapping(address => uint32) public delegatorDelegationsEpochs;


    constructor(string memory paramProposal, address paramOpTokenAddress)
    {
        delegateeOwner = msg.sender;
        proposal = paramProposal;
        opTokenAddress = paramOpTokenAddress;
    }

    function gobyingModuleDelegate() public view returns(address)
    {
        return iGovernanceToken(opTokenAddress).delegates(msg.sender);
    }
}