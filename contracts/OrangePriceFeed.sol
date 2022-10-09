// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./PushNotification.sol";

interface IOrangePriceFeed {
    function price() external view returns (uint256);
}

contract OrangePriceFeed {
    uint256 public price1 = 0;
    uint256 public price2 = 0;
    uint256 public price3 = 0;
    uint256 public averagePrice = 0;
    uint256 public flag = 0;
    uint256 public limit =
        115792089237316195423570985008687907853269984665640564039457584007913129639935;
    address orangePriceFeed1Contract;
    address orangePriceFeed2Contract;
    address orangePriceFeed3Contract;

    PushNotification pushContract;

    constructor(
        address _orangePriceFeed1Contract,
        address _orangePriceFeed2Contract,
        address _orangePriceFeed3Contract,
        address _pushNotificationContract
    ) {
        orangePriceFeed1Contract = _orangePriceFeed1Contract;
        orangePriceFeed2Contract = _orangePriceFeed2Contract;
        orangePriceFeed3Contract = _orangePriceFeed3Contract;
        pushContract = PushNotification(_pushNotificationContract);
    }

    function getPrice() public {
        price1 = IOrangePriceFeed(orangePriceFeed1Contract).price();
        price2 = IOrangePriceFeed(orangePriceFeed2Contract).price();
        price3 = IOrangePriceFeed(orangePriceFeed3Contract).price();
    }

    function calcAveragePrice() public returns (uint256) {
        averagePrice = (price1 + price2 + price3) / 3;
        if (limit <= averagePrice) {
            flag = 1;
            pushContract.notificate(msg.sender);
        } else {
            flag = 0;
        }
        return averagePrice;
    }
}
