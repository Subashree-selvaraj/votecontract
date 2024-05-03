// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract VotingSystem {
    struct Option {
        string name;
        uint256 voteCount;
    }

    Option[] public options;
    mapping(address => bool) public hasVoted;
    mapping(address => uint256) public voterOption;

    event Voted(address indexed voter, uint256 indexed optionIndex);

    constructor(string[] memory _optionNames) {
        for (uint256 i = 0; i < _optionNames.length; i++) {
            options.push(Option({name: _optionNames[i], voteCount: 0}));
        }
    }

    function vote(uint256 _optionIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_optionIndex < options.length, "Invalid option index");

        options[_optionIndex].voteCount++;
        hasVoted[msg.sender] = true;
        voterOption[msg.sender] = _optionIndex;

        emit Voted(msg.sender, _optionIndex);
    }

    function getWinner() public view returns (string memory winner) {
        uint256 maxVotes = 0;
        uint256 winningOptionIndex;

        for (uint256 i = 0; i < options.length; i++) {
            if (options[i].voteCount > maxVotes) {
                maxVotes = options[i].voteCount;
                winningOptionIndex = i;
            }
        }

        winner = options[winningOptionIndex].name;
    }
}