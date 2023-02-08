

pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../../meta-tx/contracts/EIP712MetaTransaction.sol";
import "../ERC1155Artlinx.sol";

contract ERC1155ArtlinxMeta is ERC1155Artlinx, EIP712MetaTransaction {

    event CreateERC1155ArtlinxMeta(address owner, string name, string symbol);

    function __ERC1155ArtlinxMeta_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external initializer {
        __ERC1155Artlinx_init_unchained(_name, _symbol, baseURI, contractURI);
        __MetaTransaction_init_unchained("ERC1155ArtlinxMeta", "1");
        emit CreateERC1155ArtlinxMeta(_msgSender(), _name, _symbol);
    }

    function _msgSender() internal view virtual override(ContextUpgradeable, EIP712MetaTransaction) returns (address payable) {
        return super._msgSender();
    }
}
