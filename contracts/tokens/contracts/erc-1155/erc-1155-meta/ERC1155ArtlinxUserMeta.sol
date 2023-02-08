

pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../../meta-tx/contracts/EIP712MetaTransaction.sol";
import "../ERC1155ArtlinxUser.sol";

contract ERC1155ArtlinxUserMeta is ERC1155ArtlinxUser, EIP712MetaTransaction {

    event CreateERC1155ArtlinxUserMeta(address owner, string name, string symbol);

    function __ERC1155ArtlinxUserMeta_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) external initializer {
        __ERC1155ArtlinxUser_init_unchained(_name, _symbol, baseURI, contractURI, operators);
        __MetaTransaction_init_unchained("ERC1155ArtlinxUserMeta", "1");
        emit CreateERC1155ArtlinxUserMeta(_msgSender(), _name, _symbol);
    }

    function _msgSender() internal view virtual override(ContextUpgradeable, EIP712MetaTransaction) returns (address payable) {
        return super._msgSender();
    }
}
