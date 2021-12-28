//SPDX-License-Identifier: MIT
pragma solidity ^0.6.4;

contract Verifier {
  // Returns the address that signed a given string message
  function verifyString(
    string memory message,
    bytes memory _signature
  ) public pure returns (address signer) {
    // The message header; we will fill in the length next
    string memory header = '\x19Ethereum Signed Message:\n000000';
    (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
    uint256 lengthOffset;
    uint256 length;
    assembly {
      // The first word of a string is its length
      length := mload(message) // The beginning of the base-10 message length in the prefix
      lengthOffset := add(header, 57)
    } // Maximum length we support
    require(length <= 999999); // The length of the message's length in base-10
    uint256 lengthLength = 0; // The divisor to get the next left-most message length digit
    uint256 divisor = 100000; // Move one digit of the message length to the right at a time
    while (divisor != 0) {
      // The place value at the divisor
      uint256 digit = length / divisor;
      if (digit == 0) {
        // Skip leading zeros
        if (lengthLength == 0) {
          divisor /= 10;
          continue;
        }
      } // Found a non-zero digit or non-leading zero digit
      lengthLength++; // Remove this digit from the message length's current value
      length -= digit * divisor; // Shift our base-10 divisor over
      divisor /= 10;

      // Convert the digit to its ASCII representation (man ascii)
      digit += 0x30; // Move to the next character and write the digit
      lengthOffset++;
      assembly {
        mstore8(lengthOffset, digit)
      }
    } // The null string requires exactly 1 zero (unskip 1 leading 0)
    if (lengthLength == 0) {
      lengthLength = 1 + 0x19 + 1;
    } else {
      lengthLength += 1 + 0x19;
    } // Truncate the tailing zeros from the header
    assembly {
      mstore(header, lengthLength)
    } // Perform the elliptic curve recover operation
    bytes32 check = keccak256(abi.encodePacked(header, message));
    return ecrecover(check, v, r, s);
  }
  function splitSignature(bytes memory sig)
        internal
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        // implicitly return (r, s, v)
    }
}
