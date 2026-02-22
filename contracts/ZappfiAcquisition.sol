// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IERC20.sol";

contract ZappfiAcquisition {

    address public acquiringToken;
    address public targetToken;
    uint256 public acquisitionRate;
    address public owner;

    event Acquired(address indexed user, uint256 soldAmount, uint256 receivedAmount);

    constructor(
        address _acquiringToken,
        address _targetToken,
        uint256 _rate
    ) {
        acquiringToken = _acquiringToken;
        targetToken = _targetToken;
        acquisitionRate = _rate;
        owner = msg.sender;
    }

    function executeAcquisition(uint256 amount) external {
        require(amount > 0, "Invalid amount");

        IERC20(targetToken).transferFrom(msg.sender, address(this), amount);

        uint256 payout = amount * acquisitionRate;
        IERC20(acquiringToken).transfer(msg.sender, payout);

        emit Acquired(msg.sender, amount, payout);
    }
}
