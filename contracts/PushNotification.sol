//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IPUSHCommInterface.sol";

contract PushNotification {
    address private epns_sc;
    address private channel_id;

    constructor(address _epns_sc, address _channel_id) {
        epns_sc = _epns_sc;
        channel_id = _channel_id;
    }

    function notificate(address _to, uint256 _price) public {
        IPUSHCommInterface(epns_sc).sendNotification(
            channel_id,
            _to,
            bytes(
                string(
                    abi.encodePacked(
                        "0", // this is notification identity: https://docs.epns.io/developers/developer-guides/sending-notifications/advanced/notification-payload-types/identity/payload-identity-implementations
                        "+", // segregator
                        "3", // this is payload type: https://docs.epns.io/developers/developer-guides/sending-notifications/advanced/notification-payload-types/payload (1, 3 or 4) = (Broadcast, targetted or subset)
                        "+", // segregator
                        "Price Alert", // this is notificaiton title
                        "+", // segregator
                        "The price of oranges is below € " + _price // notification body
                    )
                )
            )
        );
    }
}
