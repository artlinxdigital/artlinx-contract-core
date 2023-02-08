

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "../erc-1155/ERC1155ArtlinxUser.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC1155UserArtlinx token.
 *
 * The beacon should be initialized before call ERC1155ArtlinxUserFactory constructor.
 *
 */
contract ERC1155ArtlinxUserFactoryC2 is Ownable {
    address public beacon;

    event Create1155ArtlinxUserProxy(address proxy);

    constructor(address _beacon) {
        beacon = _beacon;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators, uint salt) external {
        address beaconProxy = deployProxy(getData(_name, _symbol, baseURI, contractURI, operators), salt);

        ERC1155ArtlinxUser token = ERC1155ArtlinxUser(address(beaconProxy));
        token.transferOwnership(_msgSender());
        emit Create1155ArtlinxUserProxy(beaconProxy);
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
    function getAddress(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators, uint _salt)
        public
        view
        returns (address)
    {   
        bytes memory bytecode = getCreationBytecode(getData(_name, _symbol, baseURI, contractURI, operators));

        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        return address(uint160(uint(hash)));
    }

    function getData(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) pure internal returns(bytes memory){
        return abi.encodeWithSelector(ERC1155ArtlinxUser(0).__ERC1155ArtlinxUser_init.selector, _name, _symbol, baseURI, contractURI, operators);
    }
}
