//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';
contract ERC721Enumerable is IERC721Enumerable, ERC721 { 
   uint256[] private _allTokens;
    //mapping from tokenId to position in _all Tokens array
      mapping(uint256=>uint256)private _allTokensIndex;
    //mapping of owner to list of all owner tokens ids
      mapping(address=>uint256[])private _ownedTokens;
    //mapping from tokenId to index of owner tokenslist
      mapping(uint256=>uint256)private _ownedTokensIndex;


    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);
constructor(){
    _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerNyIndex(bytes4)')));
}

function _mint(address to,uint256 tokenId) internal override(ERC721){
   super._mint(to,tokenId); 
    //add tokens to the owner
    //all tokens toour total supply -to allTokens
    _addTokensToAllTokenEnumeration(tokenId);
    _addTokensToOwnerEnumeration(to,tokenId);
}
//add tokens to the _alltokens
function _addTokensToAllTokenEnumeration(uint256 tokenId) private{
_allTokensIndex[tokenId]=_allTokens.length;
_allTokens.push(tokenId);
}

function _addTokensToOwnerEnumeration(address to,uint256 tokenId)private{
    //EXERCISE-
   //1.add address and token id to the _ownedTokens
   //2.ownedTokensIndex tokenId set to address of ownedTokens position
   //3. we want to execute the function with minting
   _ownedTokensIndex[tokenId]=_ownedTokens[to].length;
   _ownedTokens[to].push(tokenId);
}
//two functions-one that returns tokenByIndex and
//another one that returns tokenOfOwnerByIndex
function tokenByIndex(uint256 index)public override view returns(uint256)
{
  //make sure that index is not out of bounds of the total supply
  require(index < totalSupply(),'error global index is out of bounds!');
  return _allTokens[index];
}
function tokenOfOwnerByIndex(address owner,uint index)public override view returns(uint256)
{
require(index< balanceOf(owner),'error global index is out of bounds!');
  return _ownedTokens[owner][index];
}

//return the total supply of the allTokens array and set the positions of the token indexes
function totalSupply()public override view returns(uint256){
    return _allTokens.length;
}


}