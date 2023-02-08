

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "./ERC721ArtlinxUserMinimal.sol";
import "@openzeppelin/contracts/proxy/IBeacon.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC721ArtlinxUser token.
 *
 * The beacon should be initialized before call ERC721ArtlinxUserFactory constructor.
 *
 */
contract ERC721ArtlinxUserFactoryMinimal is Ownable {
    IBeacon public beacon;

    event Create721ArtlinxUserProxy(BeaconProxy proxy);

    constructor(IBeacon _beacon) {
        beacon = _beacon;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) external {
        bytes memory data = abi.encodeWithSelector(ERC721ArtlinxUserMinimal(0).__ERC721ArtlinxUser_init.selector, _name, _symbol, baseURI, contractURI, operators);
        BeaconProxy beaconProxy = new BeaconProxy(address(beacon), data);
        ERC721ArtlinxUserMinimal token = ERC721ArtlinxUserMinimal(address(beaconProxy));
        token.transferOwnership(_msgSender());
        emit Create721ArtlinxUserProxy(beaconProxy);
    }
}
