pragma solidity 0.7.6;
pragma abicoder v2;

import "../../royalties/contracts/LibPart.sol";

library LibOrderDataV2 {
    bytes4 public constant V2 = bytes4(keccak256("V2"));

    struct DataV2 {
        LibPart.Part[] payouts;
        LibPart.Part[] originFees;
        bool isMakeFill;
    }

    function decodeOrderDataV2(bytes memory data)
        internal
        pure
        returns (DataV2 memory orderData)
    {
        orderData = abi.decode(data, (DataV2));
    }
}
