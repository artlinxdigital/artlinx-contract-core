

pragma solidity >=0.6.2 <0.8.0;
pragma abicoder v2;

import "../erc-721-minimal/ERC721ArtlinxUserMinimal.sol";
import "@openzeppelin/contracts/proxy/BeaconProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @dev This contract is for creating proxy to access ERC721ArtlinxUser token.
 *
 * The beacon should be initialized before call ERC721ArtlinxUserFactory constructor.
 *
 */
contract ERC721ArtlinxUserFactoryC2 is Ownable {
    address public beacon;

    event Create721ArtlinxUserProxy(address proxy);

    constructor(address _beacon) {
        beacon = _beacon;
    }

    function createToken(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators, uint salt) external {
        address beaconProxy = deployProxy(getData(_name, _symbol, baseURI, contractURI, operators), salt);
        ERC721ArtlinxUserMinimal token = ERC721ArtlinxUserMinimal(address(beaconProxy));
        token.transferOwnership(_msgSender());
        emit Create721ArtlinxUserProxy(beaconProxy);
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
        return abi.encodeWithSelector(ERC721ArtlinxUserMinimal(0).__ERC721ArtlinxUser_init.selector, _name, _symbol, baseURI, contractURI, operators);
    }
}
