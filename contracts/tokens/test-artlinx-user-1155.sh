#!/usr/bin/env bash
truffle test ./test/erc-1155/ERC1155ArtlinxUser.test.js \
              ./contracts/create-2/ERC1155ArtlinxUserFactoryC2.sol \
              ./test/contracts/TestERC1271.sol