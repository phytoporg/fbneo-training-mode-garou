# Reversing notes for Garou
Just some notes on data and code to aide in building additional features for garou training. Some of this info comes from reading existing code and documentation, some from my own exploration and experimentation. This is all mostly for my own reference, but hopefully someone else may find it useful, too!

## Data
- 0x100400 : Player base
- 0x100411 : Player 1 character index
- 0x100458 : Player 1 direction
- 0x10048E : Player 1 health
- 0x1004BE : Player 1 meter
- 0x100511 : Player 2 character index
- 0x100558 : Player 2 direction
- 0x10058E : Player 2 health
- 0x1005BE : Player 2 meter
- 0x100C88 : Object pointer list (4-byte entries)
- 0x100E00 : Stage base
- 0x10748A : Match is active
- 0x107490 : Game timer value
- 0x10A39C : Player 2 hit stun
- 0x10A39D : Player 1 hit stun
- 0x10ACE4 : Player 1 guard damage
- 0x10ADE4 : Player 2 guard damage
- 0x10E008 : Player 1 credits
- 0x10E009 : Player 2 credits
- 0x21E402 : Max guard damage array (requires bank switch)
-- A byte array, offsets are character indices
