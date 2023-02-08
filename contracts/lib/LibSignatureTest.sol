

pragma solidity ^0.7.0;
pragma abicoder v2;

import "../exchange-v2/contracts/lib/LibSignature.sol";
import "../exchange-v2/contracts/LibOrder.sol";
import "@openzeppelin/contracts-upgradeable/drafts/EIP712Upgradeable.sol";

contract LibSignatureTest is EIP712Upgradeable {
    using LibSignature for bytes32;

    function recoverFromSigTest(bytes32 message, bytes memory signature,address varss) external view returns (address) {
        bytes32 _TYPE_HASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
//        "Exchange", "2"
        bytes32 hashedName = keccak256(bytes( "Exchange"));
        bytes32 hashedVersion = keccak256(bytes("2"));
        bytes32 _aa = buildDomainSeparator(_TYPE_HASH, hashedName, hashedVersion,varss);
        bytes32  hash = keccak256(abi.encodePacked("\x19\x01", _aa, message));
        return hash.recover(signature);
    }

    function recoverFromParamsTest(bytes32 hash, uint8 v, bytes32 r, bytes32 s) external pure returns (address) {
        return hash.recover(v, r, s);
    }

    function getChainId() public view  returns (uint256 chainId) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        // solhint-disable-next-line no-inline-assembly
        assembly {
            chainId := chainid()
        }
    }
    
    function buildDomainSeparator(bytes32 typeHash, bytes32 name, bytes32 version,address varss) private view returns (bytes32) {
        return keccak256(
            abi.encode(
                typeHash,
                name,
                version,
                getChainId(),
                varss
            )
        );
    }

}
