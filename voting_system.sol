// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Proposal {
        string description;
        uint256 voteCount;
    }

    address public chairperson;
    mapping(address => bool) public voters;
    Proposal[] public proposals;

    // Event that is emitted when a new vote is cast
    event VoteCast(address voter, uint256 proposalIndex);

    // Constructor to initialize the chairperson
    constructor() {
        chairperson = msg.sender;
    }

    // Function to create a new proposal
    function createProposal(string memory description) public {
        require(msg.sender == chairperson, "Only chairperson can create proposals.");
        proposals.push(Proposal({
            description: description,
            voteCount: 0
        }));
    }

    // Function to vote for a proposal
    function vote(uint256 proposalIndex) public {
        require(!voters[msg.sender], "Voter has already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal index.");

        voters[msg.sender] = true;
        proposals[proposalIndex].voteCount += 1;

        emit VoteCast(msg.sender, proposalIndex);
    }

    // Function to get the total number of proposals
    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }

    // Function to get the details of a specific proposal
    function getProposal(uint256 proposalIndex) public view returns (string memory description, uint256 voteCount) {
        require(proposalIndex < proposals.length, "Invalid proposal index.");
        return (proposals[proposalIndex].description, proposals[proposalIndex].voteCount);
    }
}
