# Symmetric vs. Asymmetric Encription

## Symmetric Encryption
  * Uses same key for encryption and decryption
  * Faster than Asymmetric Encryption
  * Less secure because you need share the same key over *insecure* communication for others to decrypt
  * Good if you will only protect the file and will not share it to others.
  * Examples: AES


## Asymmetric Encryption
  * Uses two keys: private key (secret key) and public key
  * If public key encrypts, only the private key can decrypt. If private key encrypts, only public key can decrypt. (bidirectional) 
  * Public key can be shared freely to others without any risk (you cannot derive the private key from public key)
  * Private key should be protected and backed up 
  * The private key contains your public key. (back up only the private key)
  * Asymmetric encryption addresses the weakness of symmetric encryption (how will you securely share the decryption key)
  * **Encryption**: The sender (other) encrypts the the file with your public key, the receiver (you) decrypts with your private key 
  * **Signing**: The sender (You) uses the private key to sign (encrypt) the message, while the receiver (others) uses your public key to decrypt. It proves that the message actually came from you. 
  * Examples: RSA, ECC, DSA

### OpenPGP and GPG implementation of Asymmetric Encryption
  * **Encryption**: 
    1. The file or message is encrypted first using symmetric encryption
    2. Only the symmetric decryption key is encrypted using the receiver's public key, not the whole message or file. This is done for efficiency (symmetric key is much faster)   
    3. The file's cipher text (encrypted using symmetric encryption) and the cipher text of the decryption key (encrypted using asymmetric encryption) are both sent to the receiver.

  * **Signing**: 
    1. A hash of the file or message is generated using a hashing algorithem (e.g. SHA1, SHA256)
    2. Only the hash of the file is encrypted (signed) by the sender (you) using your private key. Not the whole file is encrypted for efficiency.
    3. The original file or message together with the encrypted hash can subsequently be encrypted using the above method (optional).
