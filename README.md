# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Secrets

GnuPG is a cryptography tool that helps you manage public and private keys as well as perform encrypt, decrypt, sign, and verify operations
git-secret encrypts files and stores them inside your git repository, providing a history of changes for every commit.

Requiremnts


Encrypt

```sh
# https://www.devdungeon.com/content/gpg-tutorial
brew install gnupg
# https://git-secret.io
brew install git-secret
```

Encrypt

```sh
gpg --help
gpg --gen-key # Gen a new key (add a pass!)
gpg --export-secret-keys --armor xxxx > ./my-priv-gpg-key.asc
 
git secret init
git secret tell myemail@gmail.com
git secret add config/secrets.yml
git secret hide
```


Dencrypt

```sh
# Get the provided and import
gpg --import ./my-priv-gpg-key.asc
git secret reveal # pass is required
```
