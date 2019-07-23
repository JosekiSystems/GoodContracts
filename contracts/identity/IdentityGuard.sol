pragma solidity ^0.5.2;

import "./Identity.sol";

/* @title The IdentityGuard contract
 * @dev Contract containing an identity and
 * modifiers to ensure proper access
 */
contract IdentityGuard {

    Identity public identity;

    /* @dev Constructor. Checks if identity is a zero address
     * @param _identity The identity contract.
     */
    constructor(Identity _identity) public {
        require(_identity != Identity(0), "Supplied identity is null");
        identity = _identity;
    }

    /* @dev Modifier that requires the sender
     * to be not blacklisted
     */
    modifier onlyNotBlacklisted() {
        require(!identity.isBlacklisted(msg.sender), "Caller is blacklisted");
        _;
    }

    /* @dev Modifier that requires the given address
     * to be not blacklisted
     * @param _account The address to be checked
     */
    modifier requireNotBlacklisted(address _account) {
        require(!identity.isBlacklisted(_account), "Receiver is blacklisted");
        _;
    }

    /* @dev Modifier that requires the sender
     * to be a claimer
     */
    modifier onlyClaimer() {
        require(identity.isClaimer(msg.sender), "is not claimer");
        _;
    }

    /* @dev Modifier that requires the given address
     * to be a claimer
     * @param _account the given address
     */
    modifier requireClaimer(address _account) {
        require(identity.isClaimer(_account), "is not claimer");
        _;
    }

    /* @dev Allows anyone to set a new identity contract if
     * the given contract has been registered as a scheme
     */
    function setIdentity(Identity _identity) public {
        _identity.isRegistered();
        identity = _identity;
    }
}