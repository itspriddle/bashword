# bashword -- pure bash password generator

## Usage

Generates passwords, passphrases, or PINs.

By default, bashword generates passwords 20 characters in length that include
at least: one number, one symbol, one lower case character, and one upper case
character.

Passphrases can be generated from a word list using the `--passphrase` option.
By default passphrases are 3 words separated by `-` using words between 5 and
8 characters.

PINs can be generated using the `--pin` option. By default PINs are 4 digits
long.

### Options

*-l*, *--length LENGTH*  
    For passwords and PINs, this option specifies the total number of
    characters used, and defaults to 20 for passwords and 4 for PINs. For
    passphrases, this option specifies the total number of words used, and
    defaults to 3.

*-p*, *--passphrase*  
    Generates a passphrase using dictionary words instead of a password of
    random characters.

*-P*, *--pin*  
    Generates a numeric PIN.

*-n*, *--numbers*  
    For passwords, this option will force the password to include at least
    one numeric digit. For passphrases and PINs, this option has no
    effect.

*-N*, *--no-numbers*  
    For passwords, this option will force the password to include no
    numbers at all. For passphrases and PINs, this options has no effect.

*-s*, *--symbols*  
    For passwords, this option will force the password to include at least
    one symbol. For passphrases and PINs, this option has no effect.

*-S*, *--no-symbols*  
    For passwords, this option will force the password to include no
    symbols at all. For passphrases and PINs, this option has no effect.

*-d*, *--delimiter CHAR*  
    For passphrases, this option is the character that is used between
    words. For passwords and PINs, this option has no effect.

*-F*, *--dictionary-file PATH*  
    For passphrases, this option specifies the path to a dictionary file
    used to select words for the passphrase, and defaults to
    `/usr/share/dict/words`. If the default file cannot be found, a
    temporary wordlist will be downloaded from GitHub (see WORD LISTS
    below). For passwords and PINs, this option has no effect.

*-U*, *--upcase*  
    For passphrases, this option will cause words in the passphrase to be
    randomly UPCASED, and defaults to off. For passwords and PINs, this
    option has no effect.

*-m*, *--min-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    least LENGTH characters long. Defaults to 5. For passwords and PINs,
    this option is has no effect.

*-M*, *--max-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    most LENGTH characters long. Defaults to 8. For passwords and PINs,
    this option is has no effect.

*-L*, *--word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    exactly LENGTH characters long. This is the same as specifying a min
    and max word length of the same value. For passwords and PINs, this
    option is has no effect.

*-c*, *--count COUNT*  
    If set, generate COUNT passwords, passphrases, or PINs. Default is 1.
    Optional.

*-h*, *--help*  
    Prints help text and exits.

*-V*, *--version*  
    Prints the bashword version and exit 0.

### Examples

Generate a 20 character password with 2 digits and 2 symbols

    $ bashword

Generate a 30 character password with 2 digits and 3 symbols

    $ bashword -l 30 -d 2 -s 3

Generate a 10 character password with only alphanumeric characters

    $ bashword -s 0 -l 10

Generate a 3 word passphrase

    $ bashword -p

Generate a 5 word passphrase using ~/list.txt

    $ bashword -p -F ~/list.txt -l 5

Generate passwords for the given users

    $ { echo user1; echo user2; echo user3 } | paste - <(bashword -c 3)

### Should I use this?

Maybe. You _should_ use a password manager like 1Password, LastPass, or
BitWarden.

`bashword` makes attempts to ensure password entropy but this is not meant to
be a cryptographically secure program.

## Installation

### Install globally via make

    git clone https://github.com/itspriddle/bashword /tmp/bashword
    cd /tmp/bashword
    sudo make install PREFIX=/usr/local
    cd 
    rm -rf /tmp/bashword

### Install locally via make

    mkdir -p ~/local/src
    git clone https://github.com/itspriddle/bashword ~/local/src/bashword
    cd ~/local/src/bashword
    make install PREFIX=~/local/src/bashword

### Copy the script manually

TODO


## Development

Tests for this project are written using Bats and are in the [`test/`](./test)
directory. To install Bats and run the test suite run:

```
make test-bats
```

Bash files are also checked with Shellcheck. To run Shellcheck:

```
make test-shellcheck
```

To run Bats tests and Shellcheck:

```
make test
```

## License

MIT License. See [LICENSE](./LICENSE) in this repo.
