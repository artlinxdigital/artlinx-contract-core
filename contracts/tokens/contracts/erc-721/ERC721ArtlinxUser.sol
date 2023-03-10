

pragma solidity 0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./ERC721BurnableUpgradeable.sol";
import "./ERC721Lazy.sol";
import "../HasContractURI.sol";

contract ERC721ArtlinxUser is OwnableUpgradeable, ERC721BurnableUpgradeable, ERC721Lazy, HasContractURI {

    event CreateERC721ArtlinxUser(address owner, string name, string symbol);

    function __ERC721ArtlinxUser_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) external initializer {
        __ERC721ArtlinxUser_init_unchained(_name, _symbol, baseURI, contractURI, operators);
        emit CreateERC721ArtlinxUser(_msgSender(), _name, _symbol);
    }

    function __ERC721ArtlinxUser_init_unchained(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI, address[] memory operators) internal {
        _setBaseURI(baseURI);
        __ERC721Lazy_init_unchained();
        __Context_init_unchained();
        __ERC165_init_unchained();
        __Ownable_init_unchained();
        __ERC721Burnable_init_unchained();
        __Mint721Validator_init_unchained();
        __HasContractURI_init_unchained(contractURI);
        __RoyaltiesV2Upgradeable_init_unchained();
        __ERC721_init_unchained(_name, _symbol);
        for (uint i = 0; i < operators.length; i++) {
            setApprovalForAll(operators[i], true);
        }
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165Upgradeable, ERC721Lazy) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mintAndTransfer(LibERC721LazyMint.Mint721Data memory data, address to) public override virtual {
        require(owner() == data.creators[0].account, "minter is not the owner");
        super.mintAndTransfer(data, to);
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721Lazy, ERC721Upgradeable) {
        super._mint(to, tokenId);
    }

    uint256[50] private __gap;
}
