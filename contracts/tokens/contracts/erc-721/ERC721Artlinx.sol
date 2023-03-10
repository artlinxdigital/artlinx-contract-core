

pragma solidity 0.7.6;
pragma abicoder v2;

import "./ERC721Base.sol";

contract ERC721Artlinx is ERC721Base {

    event CreateERC721Artlinx(address owner, string name, string symbol);

    function __ERC721Artlinx_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external initializer {
        __ERC721Artlinx_init_unchained(_name, _symbol, baseURI, contractURI);
        emit CreateERC721Artlinx(_msgSender(), _name, _symbol);
    }

    function __ERC721Artlinx_init_unchained(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) internal {
        _setBaseURI(baseURI);
        __ERC721Lazy_init_unchained();
        __RoyaltiesV2Upgradeable_init_unchained();
        __Context_init_unchained();
        __ERC165_init_unchained();
        __Ownable_init_unchained();
        __ERC721Burnable_init_unchained();
        __Mint721Validator_init_unchained();
        __HasContractURI_init_unchained(contractURI);
        __ERC721_init_unchained(_name, _symbol);
    }

    uint256[50] private __gap;
}
