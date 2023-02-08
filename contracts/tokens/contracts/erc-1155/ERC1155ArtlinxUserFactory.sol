

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "./ERC1155ArtlinxUser.sol";
import "@openzeppelin/contracts/proxy/IBeacon.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC1155UserArtlinx token.
 *
 * The beacon should be initialized before call ERC1155ArtlinxUserFactory constructor.
 *
 */
contract ERC1155ArtlinxUserFactory is Ownable {
    IBeacon public beacon;

    event Create1155ArtlinxUserProxy(BeaconProxy proxy);

    constructor(IBeacon _beacon) {
        beacon = _beacon;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) external {
        bytes memory data = abi.encodeWithSelector(ERC1155ArtlinxUser(0).__ERC1155ArtlinxUser_init.selector, _name, _symbol, baseURI, contractURI, operators);
        BeaconProxy beaconProxy = new BeaconProxy(address(beacon), data);
        ERC1155ArtlinxUser token = ERC1155ArtlinxUser(address(beaconProxy));
        token.transferOwnership(_msgSender());
        emit Create1155ArtlinxUserProxy(beaconProxy);
    }
}
