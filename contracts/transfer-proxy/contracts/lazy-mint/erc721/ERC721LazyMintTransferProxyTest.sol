pragma solidity >=0.6.9 <0.8.0;
pragma abicoder v2;

import "../../../../exchange-interfaces/contracts/ITransferProxy.sol";
import "../../../../lazy-mint/contracts/erc-721/LibERC721LazyMint.sol";
import "../../../../lazy-mint/contracts/erc-721/IERC721LazyMint.sol";
import "../../roles/OperatorRole.sol";
import "hardhat/console.sol";

contract ERC721LazyMintTransferProxyTest  {
    function transfer(bytes memory bdata) public view returns (LibERC721LazyMint.Mint721Data memory data) {
        (address token, LibERC721LazyMint.Mint721Data memory data) = abi.decode(bdata, (address, LibERC721LazyMint.Mint721Data));
        console.log("Changing greeting from '%s'", data.creators[0].account);
           address minter = address(data.tokenId >> 96);
        //        address sender = _msgSender();
        //
//                require(minter == data.creators[0].account, "tokenId incorrect");
        console.log("minter '%s'",minter);
        console.log("data.tokenId '%s'",data.tokenId);
        console.log("minter '%s'", address(0xd1798c291e12ac1185438fa9c58cd0c94a0f67f1000000000000000000000007 >> 96));
        console.log("re '%s'",minter == data.creators[0].account);
    }
}
