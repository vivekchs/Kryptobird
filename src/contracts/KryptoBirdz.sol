 //SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';
contract KryptoBird is ERC721Connector{
    //array to store nfts
string [] public kryptoBirdz;
mapping(string=>bool)_kryptoBirdzExists;
function mint(string memory _kryptoBird)public{
       
       require(!_kryptoBirdzExists[_kryptoBird],'Error-kryptoBird already exists');

     kryptoBirdz.push(_kryptoBird);
     uint _id=kryptoBirdz.length-1;
     _mint(msg.sender, _id);


}

//initialize this contract to inherit 
//name and symbol from erc721Metadata so that
//the name is KryptoBird and the symbol is KBIRDZ

constructor() ERC721Connector('KryptoBird','KBIRDZ')
{}



}
