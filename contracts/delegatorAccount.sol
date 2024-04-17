//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface iGovernanceToken
{
    function delegate(address delegatee) external;
    function transfer(address to, uint256 amount) external returns(bool);
    function balanceOf(address account) external view returns(uint256);
}

interface delegateeModule
{
   function gobyingModuleDelegate() external view returns(address);
}

contract delegatorAccount
{
    address public owner;
    address public govying;
    address public opTokenAddress;

    constructor(address paramOwnerAddress, address paramOpTokenAddress)
    {
        owner = paramOwnerAddress;
        govying = msg.sender;
        opTokenAddress = paramOpTokenAddress;
    }

    function delegateToDelegateeModule(address paramDelegateeModuleAddress) public
    {
        iGovernanceToken(opTokenAddress).delegate(paramDelegateeModuleAddress);

        require(paramDelegateeModuleAddress == delegateeModule(paramDelegateeModuleAddress).gobyingModuleDelegate(), "Delegation failed.");
    }

    function withdrawGovernanceToken() public
    {
        require(msg.sender == owner || msg.sender == govying, "Not owner or govying.");

        uint256 governanceTokenBalance = iGovernanceToken(opTokenAddress).balanceOf(address(this));

        iGovernanceToken(opTokenAddress).transfer(owner, governanceTokenBalance);
    }

    function getAddress() public view returns(address)
    {
        return address(this);
    }
}