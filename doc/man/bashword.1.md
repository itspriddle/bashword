# bashword 1 "Aug 2021" bashword "User Manuals"

## SYNOPSIS

`bashword` [OPTIONS]

## DESCRIPTION

Generates passwords, passphrases, or PINs.

By default, bashword generates passwords 20 characters in length that include
at least: one number, one symbol, one lower case character, and one upper case
character.

Passphrases can be generated from a word list using the `--passphrase` option.
By default passphrases are 3 words separated by `-` using words between 5 and
8 characters.

PINs can be generated using the `--pin` option. By default PINs are 4 digits
long.

## OPTIONS

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

## EXAMPLES

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

## CONFIGURATION

bashword defaults can be configured by setting the following environment
variables (typically in `~/.profile` or `~/.bash_profile` for Bash users, or
`~/.zshenv` for ZSH users). Configuring bashword is completely optional.

- `$BASHWORD_DEFAULT_PASSWORD_LENGTH`: The default password length.
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

## WORD LISTS

By default passphrases are generated using `/usr/share/dict/words`. If that
file does not exist, one will be downloaded automatically from GitHub under
`/tmp/bashwords-words`.

## BUG REPORTS

Issues can be reported on GitHub:

<https://github.com/itspriddle/bashword/issues>

## AUTHOR

Joshua Priddle <jpriddle@me.com>

https://github.com/itspriddle/bashword#readme

## LICENSE

MIT License

Copyright (c) 2021 Joshua Priddle <jpriddle@me.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## SEE ALSO

RANDOM(4)
