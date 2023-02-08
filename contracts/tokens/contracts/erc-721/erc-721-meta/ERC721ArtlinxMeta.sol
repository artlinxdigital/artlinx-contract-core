

pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../../meta-tx/contracts/EIP712MetaTransaction.sol";
import "../ERC721Artlinx.sol";

contract ERC721ArtlinxMeta is ERC721Artlinx, EIP712MetaTransaction {

    event CreateERC721ArtlinxMeta(address owner, string name, string symbol);

    function __ERC721ArtlinxMeta_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external initializer {
        __ERC721Artlinx_init_unchained(_name, _symbol, baseURI, contractURI);
        __MetaTransaction_init_unchained("ERC721ArtlinxMeta", "1");
        emit CreateERC721ArtlinxMeta(_msgSender(), _name, _symbol);
    }

    function _msgSender() internal view virtual override(ContextUpgradeable, EIP712MetaTransaction) returns (address payable) {
        return super._msgSender();
    }
}
