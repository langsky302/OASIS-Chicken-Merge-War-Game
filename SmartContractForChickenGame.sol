// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OwnerNumberGame {
    // State variable to store the number owned by the contract owner
    int private ownerNumber;
    address private owner;
    bool private isMatched;
    int private lastGuess; // Store the last guessed number

    // Modifier to restrict functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Constructor to set the contract deployer as the owner
    constructor(int _initialNumber) {
        owner = msg.sender;
        ownerNumber = _initialNumber;
        isMatched = false;
    }

    // Function to allow the owner to update the number
    function updateOwnerNumber(int _newNumber) public onlyOwner {
        ownerNumber = _newNumber;
        isMatched = false; // Reset the match status to allow new guesses
    }

    // Function to set the guessed number and check if it matches the owner's number
    function setGuess(int _guess) public {
        require(!isMatched, "A match has already been made");

        lastGuess = _guess; // Store the guessed number

        // Check if the guessed number matches the owner's number
        if (lastGuess == ownerNumber) {
            isMatched = true; // Lock further guesses if matched
        }
    }

    // Function to check the match status
    function checkGuess() public view returns (int) {
        // Check if a match has already been made
        if (isMatched) {
            return 1; // A match has been made
        } else {
            return 2; // No match
        }
    }

    // Function to check if guessing is still allowed
    function isGuessingAllowed() public view returns (bool) {
        return !isMatched;
    }
}