// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IERC20.sol";

contract ZappfiMerger {

    address public tokenA;
    address public tokenB;
    address public mergedToken;

    uint256 public swapRatioA;
    uint256 public swapRatioB;

    address public owner;

    event TokensMerged(address indexed user, uint256 amountIn, uint256 amountOut);

    constructor(
        address _tokenA,
        address _tokenB,
        address _mergedToken,
        uint256 _swapRatioA,
        uint256 _swapRatioB
    ) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        mergedToken = _mergedToken;
        swapRatioA = _swapRatioA;
        swapRatioB = _swapRatioB;
        owner = msg.sender;
    }

    function mergeTokenA(uint256 amount) external {
        require(amount > 0, "Invalid amount");

        IERC20(tokenA).transferFrom(msg.sender, address(this), amount);

        uint256 outputAmount = amount * swapRatioA;
        IERC20(mergedToken).transfer(msg.sender, outputAmount);

        emit TokensMerged(msg.sender, amount, outputAmount);
    }

    function mergeTokenB(uint256 amount) external {
        require(amount > 0, "Invalid amount");

        IERC20(tokenB).transferFrom(msg.sender, address(this), amount);

        uint256 outputAmount = amount * swapRatioB;
        IERC20(mergedToken).transfer(msg.sender, outputAmount);

        emit TokensMerged(msg.sender, amount, outputAmount);
    }
}
