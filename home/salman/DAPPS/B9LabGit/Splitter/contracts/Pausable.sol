pragma solidity >=0.4.21 <0.6.0;

import './OwnerDetails.sol';

contract Pausable is OwnerDetails {
  // is running
  bool private _isRunning;

  // event
  event ChangeRunningEvents(bool oldValue, bool newValue);

  // constructor
  constructor(bool isRunning) public {
    _isRunning = isRunning;
  }

  // modifier
  modifier runningOnly() {
    require(_isRunning);
    _;
  }
  
  // getter
  function isRunning() public view returns (bool) {
    return _isRunning;
  }

  // set running
  function switchRunning(bool running)
    public
    ownerOnly
  {
    bool oldValue = _isRunning;
    _isRunning = running;
    emit ChangeRunningEvents(oldValue, running);
  }
}