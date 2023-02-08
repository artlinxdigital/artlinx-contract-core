

pragma solidity 0.7.6;
pragma abicoder v2;

import "./ERC1155Base.sol";

contract ERC1155Artlinx is ERC1155Base {
    event CreateERC1155Artlinx(address owner, string name, string symbol);

    function __ERC1155Artlinx_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external initializer {
        __ERC1155Artlinx_init_unchained(_name, _symbol, baseURI, contractURI);
        emit CreateERC1155Artlinx(_msgSender(), _name, _symbol);
    }

    function __ERC1155Artlinx_init_unchained(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) internal {
        __Ownable_init_unchained();
        __ERC1155Lazy_init_unchained();
        __ERC165_init_unchained();
        __Context_init_unchained();
        __Mint1155Validator_init_unchained();
        __ERC1155_init_unchained("");
        __HasContractURI_init_unchained(contractURI);
        __ERC1155Burnable_init_unchained();
        __RoyaltiesV2Upgradeable_init_unchained();
        __ERC1155Base_init_unchained(_name, _symbol);
        _setBaseURI(baseURI);
    }

    uint256[50] private __gap;
}
