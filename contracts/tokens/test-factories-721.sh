#!/usr/bin/env bash
truffle test ./test/erc-721/ERC721Factories.test.js \
              ./contracts/create-2/ERC721ArtlinxUserFactoryC2.sol \
              ./contracts/erc-721/ERC721ArtlinxUser.sol \
              ./contracts/create-2/ERC721ArtlinxFactoryC2.sol \
              ./contracts/erc-721/ERC721Artlinx.sol \
