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

https://gist.github.com/tyrcho/651fdf93de5df49e8c2e10685562206f

```sh
# https://www.devdungeon.com/content/gpg-tutorial
#brew install gnupg
brew install gnupg@2.2 # (same than ubuntu) CI: 2.2.19, 2.2.34 mmmm
# https://git-secret.io
brew install git-secret
```

Encrypt

```sh
gpg --help
gpg --gen-key # Gen a new key (add a pass!)
gpg --export-secret-keys --armor xxxx > ~/.gpg_secrets/my-priv-gpg-key.asc
cat ~/.gpg_secrets/my-priv-gpg-key.asc | pbcopy
 
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
