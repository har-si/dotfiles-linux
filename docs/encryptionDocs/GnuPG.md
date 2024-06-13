# GnuPG

GnuPG (or GPG) is GNU's implementation of OpenPG.
It supports both symmetric and asymmetric encryption [[symmetric-vs-asymmetric-encription]]

Below are the common functions with its corresponding flags:

---
## Managing GPG Keys

### Creating a key pair
Sample syntax: `gpg --full-generate-key`
  * `--full-generate-key` or `--full-gen-key`: generate private and public keys 
  * `--expert`: gain access of gpg's advance features for key generation 

### Export Public Key
Sample syntax: `gpg --export --armor --output public.asc hctsicat@gmail.com`
  * `gpg <email|keyID|UID>`
  * `--export`: flag to export public key of the specified key above
  * `--output <file name>`: specify the file name of the output file. If not specified, command will output to STDOUT
  * `--armor`: convert the output file using ASCII Armor. If not specified, output will be in binary. (use .asc file extension if ASCII armor is used. else use .pgp)

### Export Private (Secret) Key
Sample syntax: `gpg --export-secret-keys --armor --output private.asc hctsicat@gmail.com`
  * `gpg <email|keyID|UID`
  * `--export-secret-keys`: flag to export private (secret) key of the specified key above
  * `--output <file name>`: specify the file name of the output file. If not specified, command will output to STDOUT
  * `--armor`: convert the output file using ASCII Armor. If not specified, output will be in binary. (use .asc file extension if ASCII armor is used. else use .pgp)

### Import Keys or Certificates
Sample syntax: `gpg --import <filename.asc>`

### Editing the Trust Level of a Key
After importing keys, you might want to edit its trust:
`gpg --edit-key hctsicat@gmail.com` you will enter the interactive edit mode of gpg. Type `gpg> help` for interactive commands.
`gpg> trust` select trust level 5 for ultimate trust
`gpg> save`

### Generating Revocation Certificate
Sample syntax: `gpg --gen-revoke --armor --output revoke.asc hctsicat@gmail.com`
  * `gpg <email|keyID|UID`
  * `--gen-revoke`: flag to generate revocation certificate of the specified key above
  * `--output <file name>`: specify the file name of the output file. If not specified, command will output to STDOUT
  * `--armor`: convert the output file using ASCII Armor. If not specified, output will be in binary. (use .asc file extension if ASCII armor is used. else use .pgp)
Note: It is a best practice to immediately generate a revocation certificate right after you generate your keys.
When revoking a key, your private key (either primary of sub key pair) is issuing a revocation certificate to the public key telling third parties that the public key should not be used.

### Creating a QR Code as Physical Backup
Use `qrencode` to convert your back up in ascii armor format to qr code image. Split the file to 1024 bytes so not to exceed the limit of a qr code. Just concatenate the file backup after. below is a sample code:
```bash
$ qrencode -r revoke.asc -o revoke.png -d 300 -8

$ split -b 1024 -d backup-secret-key.asc backup-secret-key.asc.
$ qrencode -r backup-secret-key.asc.00 -o backup-secret-key.asc.00.png -d 300 -8
$ qrencode -r backup-secret-key.asc.01 -o backup-secret-key.asc.01.png -d 300 -8
$ qrencode -r backup-secret-key.asc.02 -o backup-secret-key.asc.02.png -d 300 -8
```
Note: you may use `zbarimg` to read qrcode images and concatenate the text. Just be aware that zbar might add a trailing blank space after the code.
Sample Syntax: `zbarimg -q --raw sourcefile.png > outputfile.txt`

### Renewing Expiry Date of the Key
`gpg --edit-key hctsicat@gmail.com` you will enter the interactive edit mode of gpg. Type `gpg> help` for interactive commands.
`gpg> expire` select the desired expiry
`gpg> save`

### List all keys
Sample syntax: `gpg --list-keys`

### Knowing the Fingerprint of Keys
Sample syntax: `gpg --fingerprint hctsicat@gmail.com`
Note: use the fingerprint of a key to confirm the validity of the key with the owner

### Signing Keys
Once you verified the validity of the key and it can be trusted, you can sign the key.
Sample syntax: `gpg --sign-key <email|keyID|UID>`
Another option is to edit the trust level of the key. see [[#Editing the Trust Level of a Key]]
After signing the key, you must export it and send it back to them. [[#Export Public Key]]
They can then import it to update the web of trust. [[#Import Keys or Certificates]]

---
## Encryption, Decryption, and Signing

### Encrypting Files (Asymmetric)
Sample Syntax: `gpg --encrypt --armor --sign -r hctsicat@gmail.com -r recipient@email.com --output output.asc filename`
Common Useful Flags:
  * `--encrypt`: tells gpg to use public-key encryption
  * `--sign`: sign the file using your private key before encrypting it.
  * `--armor`: convert the output file using ASCII Armor. If not specified, output will be in binary. (use .asc file extension if ASCII armor is used. else use .pgp)
  * `--recipient` or `-r`: Specify the recipient of the file. GPG will use the public key of the recipient to encrypt the file. By default, gpg do not encrypt for you. so you will not be able to open the file using your private key. So you might want to include yourself as recipient of the message/file.
  * `--output <file name>`: specify the file name of the output file. If not specified, command will output to STDOUT
  * `--symmetric`: further encrypt the file with a passphrase.
  * `filename`: Path of the file to encrypt. GPG also accepts STDIN. so you can `echo "hello world" | gpg --encrypt`

### Encrypting Files (Symmetric)
Sample Syntax: `gpg --symmetric --cipher-algo AES256 filename`
  * `--symmetric`: encrypt file using symmetric encryption
  * `--cipher-algo`: select the algorithem to use. Run `gpg --version` to give you the list of supported cipher algos. default is AES128.
  * `--armor`: convert the output file using ASCII Armor. If not specified, output will be in binary. (use .asc file extension if ASCII armor is used. else use .pgp)
  * `filename`: Path of the file to encrypt. GPG also accepts STDIN. so you can `echo "hello world" | gpg --encrypt`

### Decrypting Files
Sample syntax: `gpg <filename.asc>`
the default command of gpg is decrypt. You may also use the `--decrypt` or `-d` flag.
Other flags:
  * `--output <file name>`: specify the file name of the output file. If not specified, command will output to STDOUT

### Signing (Clearsign)
Clearsign option will will wrap the message in an ASCII-armored signature but will not otherwise modify its contents.
Clearsign option will wrap the image in ASCII-Armor by default
Sample syntax: `gpg --clearsign filename`

### Signing (Detached)
Creating a "detached signature" which is a separate file that contains a signature for the specified file. Original file will not be altered, unlike clear sign.
Sample syntax: `gpg --detach-sign filename`

### Verifying Signatures
Sample syntax: `gpg --verify filename.sig`
Note: You must already have the public key of the sender.

---
## Master Key and Sub Keys

### PGP Key Capabilities
GPG keys have 4 usage: (C)ertify, (A)uthenticate, (S)ign, and (E)ncrypt.
The key carrying the (C)ertify capability is considered the primary (master) key because it is the only key that can be used to indicate relationship with other keys. Only the master key can add/revoke sub keys, add/change/revoke UID, change expiry of keys, and sign other people's key for web of trust purposes.
The master/primary carrying the (C)ertify capability is your digital identity. You should protect as your own identity.
The (A)uthenticate key capability allows you to use PGP for SSH purposes.

### Relationship Between Master and Sub Keys
By default, GPG creates two key pairs: one master key (for C and S) and one sub key (for E). This means that you have two private keys and two public keys.
All sub keys are linked to the primary key by a "special kind of binding signature" issued by the primary key to the sub keys. 
The primary key holds you trust. If your primary key is certified, all your sub keys will also get the same trust certificate.
The primary key and the sub keys will all have the same key fingerprint and UID (the primary key's keyID/Fingerprint and UID). The sub keys also inherits the trust certificates being issued for primary key pair. It is a way for us to tell that the sub key pair belongs to the same identity as the primary key.
Sub keys can be revoked independently and stored separately from the primary key. Sub keys will still maintain its association with the primary key even if it is stored separately.
Revoked keys can still be used to verify signatures and decrypt files.
If you have multiple keys to perform an operation (E or S), GPG will select the newest, non-revoked key to perform that operation.
When exporting keys with `--export` and `--export-secret-keys`, you are exporting both the master key and the sub keys. 
To export only the sub keys, use `--export-secret-subkeys` flag. This will export all private sub keys excluding the primary key.

### Master Key Best Practices
* It is a best practice to keep the primary private key offline. You will only use it when creating and updating sub keys, and for certifying. Primary key should only be used in a disconnected live linux system. 
* Use the sub keys for daily operations like signing and encryption
* Steps to keep your master key offline:
  1. Have a back up of your master key [[#Creating a QR Code as Physical Backup]]
  2. Prepare an ecrypted USB Flash drive. You may use the same passphrase for as your PGP key passphrase. [VeraCrypt](https://www.veracrypt.fr/en/Home.html)
  3. Copy $HOME/.gnupg to the USb drive: `cp -rp ~/.gnupg /media/device/name/gpgbackup` This would be your offline master key storage.
  4. test your backup: `gpg --homedir=/media/device/name/gpgbackup --list-keys KEYID`
    - Your may also change the environment variable ` export GNUPGHOME=/media/device/name/gpgbackup` instead of using the `--homedir` flag.
  5. Proceed to remove the master key material from GnuPG directory:
    1. Know the keygrip of the master key: `gpg --with-keygrip --list-keys KEYID`
    2. Delete the key grip from `$HOME/.gnupg/private-keys-v1.d` using `rm KEYGRIP.key`
    3. To check, the `gpg --list-keys KEYID` command should show `sec#` instead of `sec` indicating that the master key is now offline or not available locally
* It is also a best practice to keep your revocation certificate offline and remove it locally. 
  1. Your revocation certificate is located at `~$HOME/.gnupg/openpgp-revoks.d`
  2. Remove the revocation certificate that corresponds to your KEYID: `rm KEYID.rev`

### Using your master key offline storage
1. Mount first the USB Drive containing your master key
2. Set the environment variable to tell gpg to use the offline storage as home directory: `export GNUPGHOME=/media/disk/name/gnupg-backup`
3. Test if gpg is already using the offline back up: `gpg --list-keys KEYID` this command should return a `sec` withour the `#`
4. Perform your intended operations with the master key.
5. After performing the intended changes to the key, you must import back these changes to the local GPG home directory: `gpg --export | gpg --homedir ~/.gnupg --import` 
6. Unset the environment variable: `unset GNUPGHOME`

### Key Expiration
* It is a best practice to use expiration date for sub keys. If an attacker gets hold of your private sub key, it will automatically be deactivated after the expiry. It is only the primary key that can extend or remove the expiry date of a key pair.
* Expiration date for primary key is useless. Once you get hold of the primary key, you can easily extend or remove its expiry.
* It is better to keep a **revocation certificate** instead of solely relying on key expiration date for your security in case of breach.
* [Link to the article](https://security.stackexchange.com/questions/14718/does-openpgp-key-expiration-add-to-security)

---
## References
  * GPG Manual: [GNU Privacy Handbook](https://www.gnupg.org/gph/en/manual.html)
  * Detailed PGP Guide by [Allan Eliasen](https://www.futureboy.us/pgp.html)
  * Managing keys (including QR Code back up) by [John Del Rosario](https://john2x.com/blog/managing-pgp-keys.html)
  * PGP for developers [Linux.com](https://www.linux.com/news/protecting-code-integrity-pgp-part-1-basic-pgp-concepts-and-tools/)
  * GIT and SSH Support [Git and SSH Support](https://www.linux.com/news/protecting-code-integrity-pgp-part-6-using-pgp-git/)
