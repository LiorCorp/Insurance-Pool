pragma solidity >=0.4.25 <0.6.0;

import "./Pool.sol";

contract Gouvernance is Pool {

    Survey[] surveys;
	Hacking[] hackings;

    event CreateSurvey(bytes32 title, bytes32 description);

	function createSurvey(bytes32 title, bytes32 description, uint8 exchange) external onlyOwner() {
	    surveys.length++;
		surveys.push(Survey(uint16(surveys.length), title, description, exchange, now));
		emit CreateSurvey(title, description);
	}

	function vote(uint16 idSurvey, bool status) external {
	    user[msg.sender].userVotes[user[msg.sender].userVotesSize] = Vote(idSurvey, status);
	    user[msg.sender].userVotesSize++;
	}

	function hacking(uint8 idExchange) external {
		hackings.push(Hacking(idExchange, now));
	}

	function getHackings(uint index) internal view returns(uint8, uint) {
		return (hackings[index].idExchange, hackings[index].date);
	}

	function getSurvey(uint index) external view returns(bytes32, bytes32) {
	    return (surveys[index].title, surveys[index].title);
	}

    function getSurveysNb() external view returns(uint) {
        return surveys.length;
    }
}
