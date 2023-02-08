

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "./ERC721ArtlinxMinimal.sol";
import "@openzeppelin/contracts/proxy/IBeacon.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC721Artlinx token.
 *
 * The beacon should be initialized before call ERC721ArtlinxFactory constructor.
 *
 */
contract ERC721ArtlinxFactoryMinimal is Ownable {
    IBeacon public beacon;
    address transferProxy;
    address lazyTransferProxy;

    event Create721ArtlinxProxy(BeaconProxy proxy);

    constructor(IBeacon _beacon, address _transferProxy, address _lazyTransferProxy) {
        beacon = _beacon;
        transferProxy = _transferProxy;
        lazyTransferProxy = _lazyTransferProxy;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external {
        bytes memory data = abi.encodeWithSelector(ERC721ArtlinxMinimal(0).__ERC721Artlinx_init.selector, _name, _symbol, baseURI, contractURI);
        BeaconProxy beaconProxy = new BeaconProxy(address(beacon), data);
        ERC721ArtlinxMinimal token = ERC721ArtlinxMinimal(address(beaconProxy));
        token.setDefaultApproval(transferProxy, true);
        token.setDefaultApproval(lazyTransferProxy, true);
        token.transferOwnership(_msgSender());
        emit Create721ArtlinxProxy(beaconProxy);
    }
}
