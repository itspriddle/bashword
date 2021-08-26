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

*-l LENGTH*, *--length LENGTH*  
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

*-d CHAR*, *--delimiter CHAR*  
    For passphrases, this option is the character that is used between
    words. For passwords and PINs, this option has no effect.

*-F PATh*, *--dictionary-file PATH*  
    For passphrases, this option specifies the path to a dictionary file
    used to select words for the passphrase, and defaults to
    `/usr/share/dict/words`. If the default file cannot be found, a
    temporary wordlist will be downloaded from GitHub (see WORD LISTS
    below). For passwords and PINs, this option has no effect.

*-U*, *--upcase*  
    For passphrases, this option will cause words in the passphrase to be
    randomly UPCASED, and defaults to off. For passwords and PINs, this
    option has no effect.

*-m LENGTH*, *--min-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    least LENGTH characters long. Defaults to 5. For passwords and PINs,
    this option is has no effect.

*-M LENGTH*, *--max-word-length LENGTH*  
    For passphrases, this option will choose words in the passphrase at
    most LENGTH characters long. Defaults to 8. For passwords and PINs,
    this option is has no effect.

*-L LENGTH*, *--word-length LENGTH*  
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
    Prints the bashword version and exit 0.

## EXAMPLES

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
