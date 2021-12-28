//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract VerifySignature {
    
    function verify(
        bytes32 messageHash,
        bytes memory signature,
        address _signer
    ) public pure returns (string memory,string memory) {

        bool v=recoverSigner(messageHash, signature) == _signer;
        string memory res;string memory status;
        if(v) {res="Signature Verification Successful!";status="Thanks, your message has been received!";}
        else {res="Signature verifiction Failed!!";status="INVALID ADDRESS!!";}
        return (res,status);
    }

    function recoverSigner(bytes32 messageHash, bytes memory _signature)
        internal
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

        return ecrecover(messageHash, v, r, s);
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
