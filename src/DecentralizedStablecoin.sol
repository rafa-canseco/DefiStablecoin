// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";/*
*@title. DecentralizedStableCoin
*@author Rafael Canseco
*Collateral : Exogenous (ETH & BTC)
*Minting: Algorithmic
*Relative Stability : Pegged to USD
*
* This is the contract meant to be governed by DSCEngine. this contract is just the ERC20
implementation of our stablecoin system.
*/
contract DecentralizedStableCoin is ERC20Burnable,Ownable{
    error DescentralizedStableCoin_MustBeMoreThanZero();
    error DescentralizedStableCoin_BurnAmountExceedsBalance();
    error DescentralizedStableCoin_notZeroAddress();

    constructor() ERC20("DecentralizedStableCoin","DSC") {}


    function burn(uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0 ){
            revert DescentralizedStableCoin_MustBeMoreThanZero();
        }
        if (balance < _amount){
            revert  DescentralizedStableCoin_BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool){
        if(_to == address(0)){
            revert  DescentralizedStableCoin_notZeroAddress();
        }
        if (_amount <= 0){
            revert DescentralizedStableCoin_MustBeMoreThanZero();
        }
        _mint(_to,_amount);
        return true;

    }

}