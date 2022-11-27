// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

/*
Building out the minting function because we want nft to:
    a.Point to an address
    b.keep track of token ids
    c.keep tack of token owner address to token ids
    d.keep tack of how many tokens address owner has
    e.create an event that emits a transfer log - contract address,where it is minted to,the ids

*/ 

contract ERC721 is ERC165, IERC721 {



    // Mapping in solidity use to create hash table of key pair value

//Mapping from token id to the owner
mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    // Mapping from token id to approved addresses;
    mapping(uint => address) private _tokenApprovals;

// Exercise: 1. Register The Interface For the ERC721 contract so that it includes 
// the folloing functions: balanceOf, ownerOf, transformFrom 
// *note by register the interface: Write the constructor with the according byte conversion

//2. Register The Interface For The ERC721Enumeration contract so that includes
// totalSupply, tokenByIndex, tokenOfOwnerByIndex functions

//3. Register The Interface For The ERC721Metadata contract so that includes name and the symbol function




constructor() {
    _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
}

    function balanceOf(address _owner) public view override returns(uint256) {
        require(_owner != address(0), 'owner query for nonexistence tokens');
        return _OwnedTokensCount[_owner];
    } 
 
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT

    function ownerOf(uint256 _tokenId) public view override returns (address){
        address owner =  _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for nonexistence tokens');
        return owner;
    }




    // Solution of above combined questions

        function _exists(uint256 tokenId) internal view returns(bool) {
// setting the address of nft owner to check the mapping of address ffrom tokenOwner at tokenId
            address owner = _tokenOwner[tokenId];
// returns the truthiness of the address is not zero.
            return owner != address(0);
        }

    function _mint(address to, uint256 tokenId) internal virtual {
    
        //Function for requires that the address isn't zero;
        require(to != address(0), 'ERC721: minting to zero(invalid) address');

        //Function for requires that the token doesn't already exist;
        require(!_exists(tokenId),'ER721: token already minted');

        //Function for adding new address to tokenId for minting;
            _tokenOwner[tokenId]=to;

        //Fuction for keeping track of each address that is minting adding one to count;
            _OwnedTokensCount[to]+=1;

            emit Transfer(address(0), to, tokenId);
    }


      /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {

    require(_to != address(0),'Error - ERC721 Transfer to zero address');
    require(ownerOf(_tokenId)==_from, 'Trying to Transfer the address does not owned');

    _OwnedTokensCount[_from]-=1;
    _OwnedTokensCount[_to]+=1;

    _tokenOwner[_tokenId] = _to;
    emit Transfer(_from, _to,_tokenId);
    }
    function transferFrom(address _from, address _to, uint256 _tokenId ) override public {
    _transferFrom(_from, _to, _tokenId);
}

}