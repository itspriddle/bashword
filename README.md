# bashword -- pure Bash password generator

`bashword` is a password generator written in
[Bash](https://www.gnu.org/software/bash/). It has no dependencies other than
Bash and is designed to work on the versions shipped with macOS, Linux, and
Windows WSL.

Attempts have been made to ensure `bashword` generates random results, but it
is not meant to be a cryptographically secure program. It is mainly intended
to supplement a password manager like [1Password](https://1password.com),
[LastPass](https://www.lastpass.com), or [BitWarden](https://bitwarden.com) by
providing a quick way to generate a password that the manager can auto-save.

The main goal of `bashword` is to encourage healthy password practices by
providing an easy to use tool that can be very quickly installed across a
variety of modern computers.

## Usage

By default, `bashword` generates passwords 20 characters in length that
include at least: one number, one symbol, one lower case character, and one
upper case character.

Passphrases can be generated from a word list using the `--passphrase` option.
By default passphrases are 3 words separated by `-` using words between 5 and
8 characters.

PINs can be generated using the `--pin` option. By default PINs are 4 digits
long.

### Options

*-LENGTH*, *--length LENGTH*  
    For passwords and PINs, this option specifies the total number of
    characters used, and defaults to 20 for passwords and 4 for PINs. When
    used along with options `-s`, `-n`, `-u`, or `-l`, an error is emitted if
    they would prevent the specified length from being met (i.e. `-s 20` would
    exceed a LENGTH of 10).  For passphrases, this option specifies the total
    number of words used, and defaults to 3.

*-p*, *--passphrase*  
    Generates a passphrase using dictionary words instead of a password of
    random characters.

*-P*, *--pin*  
    Generates a numeric PIN.

*-n [COUNT]*, *--numbers [COUNT]*  
    For passwords, this option specifies the number of numbers to include in
    the generated password. If no COUNT is specified, at least one number is
    guaranteed to be included. For passphrases and PINs, this option has no
    effect.

*-N*, *--no-numbers*  
    For passwords, this option forces the password to include no numbers at
    all. For passphrases and PINs, this options has no effect.

*-s [COUNT]*, *--symbols [COUNT]*  
    For passwords, this option specifies the number of symbols to include in
    the generated password. If no COUNT is specified, at least one symbol is
    guaranteed to be included. For passphrases and PINs, this option has no
    effect.

*-S*, *--no-symbols*  
    For passwords, this option forces the password to include no symbols at
    all. For passphrases and PINs, this option has no effect.

*-d CHAR*, *--delimiter CHAR*  
    For passphrases, this option is the character that is used between
    words. For passwords and PINs, this option has no effect.

*-F PATH*, *--dictionary-file PATH*  
    For passphrases, this option specifies the path to a dictionary file
    used to select words for the passphrase, and defaults to
    `/usr/share/dict/words`. If the default file cannot be found, a
    temporary wordlist will be downloaded from GitHub (see WORD LISTS
    below). For passwords and PINs, this option has no effect.

*-u [COUNT]*, *--upcase [COUNT]*  
    For passwords, this option specifies the number of uppercase letters to
    include in the generated password. If no COUNT is specified, at least one
    uppercase letter is guaranteed to be included. By default, passwords
    include at least one uppercase character. For passphrases, this option
    specifies the number of uppercase words to include in the generated
    passphrase. If no COUNT is specified, at least one uppercase word is
    guaranteed to be included. By default, passphrases do not include an
    uppercase word. For passwords and PINs, this option has no effect.

*-U*, *--no-upcase*  
    For passwords, this option forces the password to have no uppercase
    characters at all. For passphrases, this option forces the passphrase to
    include no uppercase words at all. For PINs, this option has no effect.

*-l [COUNT]*, *--lower [COUNT]*  
    For passwords, this option specifies the number of lowercase characters to
    include in the generated password. If no COUNT is supplied, at least one
    lowercase character is guaranteed to be provided. By default passwords
    include at least one lowercase character. For passphrases, this option
    specifies the number of lowercase words to include in the generated
    passphrase. If no COUNT is specified, at least one lowercase word is
    guaranteed to be included. By default, passphrases do not include an
    uppercase word. For PINs, this option has no effect.

*-L*, *--no-lower*  
    For passwords, this option forces the password to have no lowercase
    characters at all. For passphrases, this option forces the passphrase to
    include no lowercase words at all. For PINs, this option has no effect.

*-m LENGTH*, *--min-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    least LENGTH characters long. Defaults to 5. For passwords and PINs,
    this option is has no effect.

*-M LENGTH*, *--max-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    most LENGTH characters long. Defaults to 8. For passwords and PINs,
    this option is has no effect.

*-w LENGTH*, *--word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    exactly LENGTH characters long. This is the same as specifying a min
    and max word length of the same value. For passwords and PINs, this
    option is has no effect.

*-c COUNT*, *--count COUNT*  
    If set, generate COUNT passwords, passphrases, or PINs. Default is 1.
    Optional.

*-h*, *--help*  
    Prints help text and exits.

*-V*, *--version*  
    Prints the bashword version and exits.

### Examples

Generate a 20 character password with digits and symbols

    $ bashword

Generate a 30 character password with digits and symbols

    $ bashword -30

Generate a 10 character password with only alphanumeric characters

    $ bashword -S -10

Generate a 3 word passphrase

    $ bashword -p

Generate a 5 word passphrase using ~/list.txt

    $ bashword -p -F ~/list.txt -5

Generate passwords for the given users

    $ { echo user1; echo user2; echo user3 } | paste - <(bashword -c 3)

### Configuration

bashword defaults can be configured by setting the following environment
variables (typically in `~/.profile` or `~/.bash_profile` for Bash users, or
`~/.zshenv` for ZSH users). Configuring bashword is completely optional.

- `$BASHWORD_DEFAULT_PASSWORD_LENGTH`: The default password length to use.
- `$BASHWORD_DEFAULT_PASSPHRASE_WORD_LIST`: The default word list file to use
  for generating passphrase words.
- `$BASHWORD_DEFAULT_PASSPHRASE_MIN_WORD_LENGTH`: The default minimum word
  length for words selected for passphrases.
- `$BASHWORD_DEFAULT_PASSPHRASE_MAX_WORD_LENGTH`: The default maximum word
  length for words selected for passphrases.
- `$BASHWORD_DEFAULT_PASSPHRASE_WORD_COUNT`: The default number of words
  chosen for passphrases.
- `$BASHWORD_DEFAULT_PASSPHRASE_DELIMITER`: The default character used between
  passphrase words.
- `$BASHWORD_DEFAULT_PIN_LENGTH`: The default length for PINs.

Full example:

    export BASHWORD_DEFAULT_PASSWORD_LENGTH=30
    export BASHWORD_DEFAULT_PASSPHRASE_WORD_LIST="$HOME/.words"
    export BASHWORD_DEFAULT_PASSPHRASE_MIN_WORD_LENGTH=4
    export BASHWORD_DEFAULT_PASSPHRASE_MAX_WORD_LENGTH=4
    export BASHWORD_DEFAULT_PASSPHRASE_WORD_COUNT=5
    export BASHWORD_DEFAULT_PASSPHRASE_DELIMITER=":"
    export BASHWORD_DEFAULT_PIN_LENGTH=6

## Installation

`bashword` includes the main [`bin/bashword`](./bin/bashword) bash script and
an optional man page
[`share/man/man1/bashword.1`](./share/man/man1/bashword.1).

To install `bashword`, the bash script needs to be copied to a directory in
your `$PATH`. If you want `man bashword` to work, the man page needs to be
copied to a directory in your `$MANPATH`.

### Install globally via make

macOS and most Linux distributions add `/usr/local/bin` to `$PATH` and
`/usr/local/share/man` to `$MANPATH`. If you are the only user on the
machine, or if you want to make `bashword` available for all users, you can
install it globally as follows:

    git clone https://github.com/itspriddle/bashword /tmp/bashword
    cd /tmp/bashword
    sudo make install PREFIX=/usr/local
    cd 
    rm -rf /tmp/bashword

### Install locally via make

If you don't want a global installation, another common pattern is to install
to `~/.local`. This is enabled on Ubuntu by default.

    mkdir -p ~/.local/src
    git clone https://github.com/itspriddle/bashword ~/.local/src/bashword
    cd ~/.local/src/bashword
    make install PREFIX=~/.local

To test, verify that `bashword -V` works and that `man bashword` prints the
man page.

If you see `bashword: command not found`, you need to update your `$PATH`. If
you are using Bash, add the following to `~/.bash_profile`, or if you are
using ZSH, add it to `~/.zshenv`:

    export PATH="$HOME/.local/bin:$PATH"

If `man bashword` reports `No manual entry for bashword`, you need to update
your `$MANPATH`. This can be done by adding the following to `~/.manpath`
(note, change USER to your username):

    MANDATORY_MANPATH /home/USER/.manpath

### Copy the script manually

The `bashword` script can also be downloaded manually and saved to any
director in your `$PATH` (such as `/usr/local/bin` or `~/.local/bin` as
described above).

    curl -s -L https://github.com/itspriddle/bashword/raw/master/bin/bashword > /tmp/bashword
    sudo mv /tmp/bashword /usr/local/bin
    sudo chmod +x /usr/local/bin/bashword
    bashword -V

## Development

### Tests

Tests for this project are written using
[Bats](https://github.com/bats-core/bats-core) and are in the
[`test/`](./test) directory. To install Bats and run the test suite run:

    make test-bats

Bash files are also checked with [ShellCheck](https://www.shellcheck.net). To
run ShellCheck:

    make test-shellcheck

To run Bats tests and ShellCheck:

    make test

### Documentation

Documentation for this project exists in:

- This README file
- The [`bin/bashword`](./bin/bashword) script's comments at the top of the
  file (shown when `bashword --help` is used)
- The Markdown file at [`doc/man/bashword.1.md`](./doc/man/bashword.1.md) that
  the man page is generated from

If documentation is updated it should be done in all of the places above.

The man page is written in Markdown in the
[`doc/man/bashword.1.md`](./doc/man/bashword.1.md) file. The
[kramdown-man](https://github.com/postmodern/kramdown-man) Ruby Gem is used to
generate a roff file that `man` uses.

If you have Ruby installed, the kramdown-man gem can be installed as follows:

    gem install kramdown-man

The roff file can be generated using:

    make share/man/man1/bashword.1

This will regenerate `share/man/man1/bashword.1` from the contents of
`doc/man/bashword.1.md`. Both files should be committed to the repo.

## License

MIT License. See [LICENSE](./LICENSE) in this repo.
