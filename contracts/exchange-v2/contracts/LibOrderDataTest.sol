pragma solidity 0.7.6;
pragma abicoder v2;

import "./LibOrder.sol";
import "../../royalties/contracts/LibPart.sol";
//import "hardhat/console.sol";

contract LibOrderDataTest {

    struct DataV1 {
        LibPart.Part[] payouts;
        LibPart.Part[] originFees;
    }

    struct DataV2 {
        LibPart.Part[] payouts;
        LibPart.Part[] originFees;
        bool isMakeFill;
    }

    function parse(LibOrder.Order memory order) public view returns (LibOrderDataV2.DataV2 memory dataOrder) {
        //        console.log("LibOrderDataV1.V1",LibOrderDataV1.V1);
        //        console.log("order.dataType",order.dataType);
        if (order.dataType == LibOrderDataV1.V1) {
            LibOrderDataV1.DataV1 memory dataV1 = LibOrderDataV1.decodeOrderDataV1(order.data);
            dataOrder.payouts = dataV1.payouts;
            dataOrder.originFees = dataV1.originFees;
            dataOrder.isMakeFill = false;
        } else if (order.dataType == LibOrderDataV2.V2) {
            dataOrder = LibOrderDataV2.decodeOrderDataV2(order.data);
        } else if (order.dataType == 0xffffffff) {
        } else {
            revert("Unknown Order data type");
        }
        if (dataOrder.payouts.length == 0) {
            dataOrder.payouts = payoutSet(order.maker);
        }
    }

    function parse1(LibOrder.Order memory order) public view returns (LibOrder.Order memory) {
        return order;
    }

    function decodeOrderDataV1(bytes memory data) public view returns (DataV1 memory orderData) {
        orderData = abi.decode(data, (DataV1));
    }

    function decodeOrderDataV2(bytes memory data)
    public view
    returns (DataV2 memory orderData)
    {
        orderData = abi.decode(data, (DataV2));
    }

    function payoutSet(address orderAddress) public view returns (LibPart.Part[] memory) {
        LibPart.Part[] memory payout = new LibPart.Part[](1);
        payout[0].account = payable(orderAddress);
        payout[0].value = 10000;
        return payout;
    }
}
