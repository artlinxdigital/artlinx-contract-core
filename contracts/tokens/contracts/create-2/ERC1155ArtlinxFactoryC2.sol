

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "../erc-1155/ERC1155Artlinx.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC1155Artlinx token.
 *
 * The beacon should be initialized before call ERC1155ArtlinxFactory constructor.
 *
 */
contract ERC1155ArtlinxFactoryC2 is Ownable{
    address public beacon;
    address transferProxy;
    address lazyTransferProxy;

    event Create1155ArtlinxProxy(address proxy);

    constructor(address _beacon, address _transferProxy, address _lazyTransferProxy) {
        beacon = _beacon;
        transferProxy = _transferProxy;
        lazyTransferProxy = _lazyTransferProxy;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, uint salt) external {        
        address beaconProxy = deployProxy(getData(_name, _symbol, baseURI, contractURI), salt);

        ERC1155Artlinx token = ERC1155Artlinx(beaconProxy);
        token.setDefaultApproval(transferProxy, true);
        token.setDefaultApproval(lazyTransferProxy, true);
        token.transferOwnership(_msgSender());
        emit Create1155ArtlinxProxy(beaconProxy);
    }

    //deploying BeaconProxy contract with create2
    function deployProxy(bytes memory data, uint salt) internal returns(address proxy){
        bytes memory bytecode = getCreationBytecode(data);
        assembly {
            proxy := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
            if iszero(extcodesize(proxy)) {
                revert(0, 0)
            }
        }
    }

    //adding constructor arguments to BeaconProxy bytecode
    function getCreationBytecode(bytes memory _data) internal view returns (bytes memory) {
        return abi.encodePacked(type(BeaconProxy).creationCode, abi.encode(beacon, _data));
    }

    //returns address that contract with such arguments will be deployed on
    function getAddress(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, uint _salt)
        public
        view
        returns (address)
    {   
        bytes memory bytecode = getCreationBytecode(getData(_name, _symbol, baseURI, contractURI));

        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        return address(uint160(uint(hash)));
    }

    function getData(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) pure internal returns(bytes memory){
        return abi.encodeWithSelector(ERC1155Artlinx(0).__ERC1155Artlinx_init.selector, _name, _symbol, baseURI, contractURI);
    }

}
