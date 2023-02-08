

pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../../meta-tx/contracts/EIP712MetaTransaction.sol";
import "../ERC721ArtlinxUser.sol";

contract ERC721ArtlinxUserMeta is ERC721ArtlinxUser, EIP712MetaTransaction {

    event CreateERC721ArtlinxUserMeta(address owner, string name, string symbol);

    function __ERC721ArtlinxUserMeta_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) external initializer {
        __ERC721ArtlinxUser_init_unchained(_name, _symbol, baseURI, contractURI, operators);
        __MetaTransaction_init_unchained("ERC721ArtlinxUserMeta", "1");
        emit CreateERC721ArtlinxUserMeta(_msgSender(), _name, _symbol);
    }

    function _msgSender() internal view virtual override(ContextUpgradeable, EIP712MetaTransaction) returns (address payable) {
        return super._msgSender();
    }
}
