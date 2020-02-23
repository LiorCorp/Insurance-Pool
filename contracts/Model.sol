pragma solidity >=0.4.25 <0.6.0;

import "./Owned.sol";

contract Model is Owned {

    struct User {
        mapping (uint8 => UserPool) userPools;
        mapping (uint16 => Vote) userVotes;
        uint8 userPoolsSize;
        uint8 userVotesSize;
    }

    struct Pool {
        uint16 id;
        uint8 poolType;
        uint8[] exchanges;
    }

    struct UserPool {
        uint16 idPool;
        uint8 exchange;
    }

    struct Survey {
        uint16 id;
        bytes32 title;
        bytes32 description;
        uint8 idExchange;
        uint date;
    }

    struct Hacking {
        uint8 idExchange;
        uint date;
    }

    struct Vote {
        uint16 idSurvey;
        bool status;
    }
}
