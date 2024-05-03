const { buildModule }= require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("Vote", (m) =>{
    const arg = m.getParameter("_optionNames",["hello"]);
    const hasVoted =m.contract("VotingSystem",[arg]);
   
    return hasVoted;

});

