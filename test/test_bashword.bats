load test_helper

@test "bashword: generates a 20 character password with letters, numbers, and symbols by default" {
  run bashword

  assert_output --regexp "^[[:alnum:][:punct:]]{20}$"
  assert_success
}

@test "bashword --length LENGTH: generates a password of the specified length" {
  _assert_results() {
    assert_output --regexp "^[[:alnum:][:punct:]]{35}$"
    assert_success
  }

  run bashword --length 35
  _assert_results

  run bashword --length=35
  _assert_results

  run bashword -35
  _assert_results
}

@test "bashword --length LENGTH: errors if options prevent given LENGTH" {
  run bashword -30 -s1 -n1 -u1 -l1
  assert_failure

  run bashword -30 -S -N -U -L
  assert_failure

  run bashword -30 -s10 -n10 -u10 -l
  assert_failure

  run bashword -10 -s1 -u8 -l1 -n
  assert_failure
}

@test "bashword --length requires a value" {
  run bashword --length
  assert_must_specify_value --length

  run bashword --length=
  assert_must_specify_value --length=
}

@test "bashword --symbols: generates a password with symbols" {
  _assert_results() {
    assert_characters "[[:punct:]]" "$1"
    assert_success
  }

  run bashword --symbols
  _assert_results

  run bashword --symbols 5
  _assert_results 5

  run bashword --symbols=6
  _assert_results 6

  run bashword -s
  _assert_results

  run bashword -s3
  _assert_results 3

  run bashword -s 4
  _assert_results 4
}

@test "bashword --symbols requires a value" {
  run bashword --symbols=
  assert_must_specify_value --symbols=
}

@test "bashword --numbers: generates a password with at least one number" {
  _assert_results() {
    assert_characters "[[:digit:]]" "$1"
    assert_success
  }

  run bashword --numbers
  _assert_results

  run bashword -n
  _assert_results

  run bashword -n3
  _assert_results 3

  run bashword -n 4
  _assert_results 4

  run bashword --numbers 5
  _assert_results 5

  run bashword --numbers=6
  _assert_results 6
}

@test "bashword --numbers requires a value" {
  run bashword --numbers=
  assert_must_specify_value --numbers=
}

@test "bashword --lower: generates a password with at least one lowercase character" {
  _assert_results() {
    assert_characters "[[:lower:]]" "$1"
    assert_success
  }

  run bashword --lower
  _assert_results

  run bashword -l
  _assert_results

  run bashword -l3
  _assert_results 3

  run bashword -l 4
  _assert_results 4

  run bashword --lower 5
  _assert_results 5

  run bashword --lower=6
  _assert_results 6
}

@test "bashword --lower requires a value" {
  run bashword --lower=
  assert_must_specify_value --lower=
}

@test "bashword --upcase: generates a password with at least one uppercase character" {
  _assert_results() {
    assert_characters "[[:upper:]]" "$1"
    assert_success
  }

  run bashword --upcase
  _assert_results

  run bashword -u
  _assert_results

  run bashword -u3
  _assert_results 3

  run bashword -u 4
  _assert_results 4

  run bashword --upcase 5
  _assert_results 5

  run bashword --upcase=6
  _assert_results 6

  run bashword --upcase=
  assert_must_specify_value --upcase=
}

@test "bashword --no-symbols: generates a password with no symbols" {
  _assert_results() {
    assert_output --regexp "^[^[:punct:]]+$"
    assert_success
  }

  run bashword --no-symbols
  _assert_results

  run bashword -S
  _assert_results

  run bashword -s0
  _assert_results

  run bashword --symbols=0
  _assert_results
}

@test "bashword --no-numbers: generates a password with no numbers" {
  _assert_results() {
    assert_output --regexp "^[^[:digit:]]+$"
    assert_success
  }

  run bashword --no-numbers
  _assert_results

  run bashword -N
  _assert_results

  run bashword -n0
  _assert_results

  run bashword --numbers=0
  _assert_results
}


@test "bashword --no-upcase: generates a password with no uppercase characters" {
  _assert_results() {
    assert_output --regexp "^[^[:upper:]]+$"
    assert_success
  }

  run bashword --no-upcase
  _assert_results

  run bashword -U
  _assert_results

  run bashword -u0
  _assert_results

  run bashword --upcase=0
  _assert_results
}

@test "bashword --no-lower: generates a password with no lowercase characters" {
  _assert_results() {
    assert_output --regexp "^[^[:lower:]]+$"
    assert_success
  }

  run bashword --no-lower
  _assert_results

  run bashword -L
  _assert_results

  run bashword -l0
  _assert_results

  run bashword --lower=0
  _assert_results
}

@test "bashword --count COUNT: generates multiple passwords" {
  _assert_results() {
    assert_output_lines_match 3 "^[[:alnum:][:punct:]]{20}$"
    assert_success
  }

  run bashword --count 3
  _assert_results

  run bashword --count=3
  _assert_results

  run bashword -c 3
  _assert_results

  run bashword -c3
  _assert_results
}

@test "bashword --count requires a value" {
  run bashword --count=
  assert_must_specify_value --count=

  run bashword --count
  assert_must_specify_value --count

  run bashword -c
  assert_must_specify_value -c
}

@test "bashword --passphrase: generates a passphrase with 3 5-8 character words by default" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase
  _assert_results

  run bashword -p
  _assert_results
}

@test "bashword --passphrase --length LENGTH: generates a passphrase with the specified number of words" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase --length 4
  _assert_results

  run bashword --passphrase --length=4
  _assert_results

  run bashword -p -4
  _assert_results

  run bashword -p -4
  _assert_results
}

@test "bashword --passphrase --length requires a value" {
  run bashword --passphrase --length
  assert_must_specify_value --length

  run bashword --passphrase --length=
  assert_must_specify_value --length=
}

@test "bashword --passphrase --word-length LENGTH: generates a passphrase with words of the exact length specified" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{6}-[[:alpha:]]{6}-[[:alpha:]]{6}$"
    assert_success
  }

  run bashword --passphrase --word-length 6
  _assert_results

  run bashword --passphrase --word-length=6
  _assert_results

  run bashword --passphrase -w 6
  _assert_results

  run bashword --passphrase -w6
  _assert_results

  run bashword --passphrase --word-length=
  assert_must_specify_value --word-length=
}

@test "bashword --passphrase --word-length requires a value" {
  run bashword --passphrase --word-length
  assert_must_specify_value --word-length

  run bashword --passphrase -w
  assert_must_specify_value -w
}

@test "bashword --passphrase --max-word-length LENGTH generates a passphrase with words of the given max lengths" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{1,10}-[[:alpha:]]{1,10}-[[:alpha:]]{1,10}$"
    assert_success
  }

  run bashword --passphrase --max-word-length 10
  _assert_results

  run bashword --passphrase --max-word-length=10
  _assert_results

  run bashword --passphrase -M 10
  _assert_results

  run bashword --passphrase -M10
  _assert_results
}

@test "bashword --passphrase --max-word-length requires a value" {
  run bashword --passphrase --max-word-length=
  assert_must_specify_value --max-word-length=

  run bashword --passphrase --max-word-length
  assert_must_specify_value --max-word-length

  run bashword --passphrase -M
  assert_must_specify_value -M
}

@test "bashword --passphrase --min-word-length LENGTH generates a passphrase with words of the given min lengths" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,}-[[:alpha:]]{5,}-[[:alpha:]]{5,}$"
    assert_success
  }

  run bashword --passphrase --min-word-length 5
  _assert_results

  run bashword --passphrase --min-word-length=5
  _assert_results

  run bashword --passphrase -m 5
  _assert_results

  run bashword --passphrase -m5
  _assert_results
}

@test "bashword --passphrase --min-word-length requires a value" {
  run bashword --passphrase --min-word-length=
  assert_must_specify_value --min-word-length=

  run bashword --passphrase --min-word-length
  assert_must_specify_value --min-word-length

  run bashword --passphrase -m
  assert_must_specify_value -m
}

@test "bashword --passphrase --upcase: upcases one word" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
    assert_output --regexp "-?[[:upper:]]{5,8}-?"
    assert_success
  }

  run bashword --passphrase --upcase
  _assert_results

  run bashword --passphrase -u
  _assert_results

  run bashword --passphrase --upcase=1
  _assert_results

  run bashword --passphrase -u1
  _assert_results

  run bashword --passphrase --upcase 1
  _assert_results

  run bashword --passphrase -u 1
  _assert_results
}

@test "bashword --passphrase --delimiter CHAR: sets the given character as the delimiter" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}:[[:alpha:]]{5,8}:[[:alpha:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase --delimiter ":"
  _assert_results

  run bashword --passphrase --delimiter=":"
  _assert_results

  run bashword --passphrase -d :
  _assert_results

  run bashword --passphrase -d:
  _assert_results
}

@test "bashword --passphrase --delimiter requires a value" {
  run bashword --passphrase --delimiter=
  assert_must_specify_value --delimiter=

  run bashword --passphrase --delimiter
  assert_must_specify_value --delimiter

  run bashword --passphrase -d
  assert_must_specify_value -d
}

@test "bashword --passphrase --count COUNT: generates the given number of passphrases" {
  _assert_results() {
    assert_output_lines_match 3 "^[[:alpha:]]{5,10}-[[:alpha:]]{5,10}-[[:alpha:]]{5,10}$"
    assert_success
  }

  run bashword --passphrase --count 3
  _assert_results

  run bashword --passphrase --count=3
  _assert_results

  run bashword --passphrase -c 3
  _assert_results

  run bashword --passphrase -c3
  _assert_results
}

@test "bashword --passphrase --count requires a value" {
  run bashword --passphrase --count=
  assert_must_specify_value --count=

  run bashword --passphrase --count
  assert_must_specify_value --count

  run bashword --passphrase -c
  assert_must_specify_value -c
}

@test "bashword --passphrase --dictionary-file FILE works with a custom word list" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase --dictionary-file test/fixtures/words
  _assert_results

  run bashword --passphrase --dictionary-file=test/fixtures/words
  _assert_results

  run bashword --passphrase -Ftest/fixtures/words
  _assert_results

  run bashword --passphrase -F test/fixtures/words
  _assert_results

  run bashword --passphrase -F test/fixtures/words-windows
  _assert_results
}

@test "bashword --passphrase --dictionary-file requires a value" {
  run bashword --passphrase -F
  assert_must_specify_value -F

  run bashword --passphrase --dictionary-file
  assert_must_specify_value --dictionary-file

  run bashword --passphrase --dictionary-file=
  assert_must_specify_value --dictionary-file=
}

@test "bashword --pin: generates a numeric PIN 4 characters long by default" {
  _assert_results() {
    assert_output --regexp "^[0-9]{4}$"
    assert_success
  }

  run bashword --pin
  _assert_results

  run bashword -P
  _assert_results
}

@test "bashword --pin --length LENGTH: generates a PIN of the given length" {
  _assert_results() {
    assert_output --regexp "^[0-9]{6}$"
    assert_success
  }

  run bashword --pin --length 6
  _assert_results

  run bashword --pin --length=6
  _assert_results

  run bashword --pin -6
  _assert_results

  run bashword --pin -6
  _assert_results
}

@test "bashword --pin --length requires a value" {
  run bashword --pin --length
  assert_must_specify_value --length

  run bashword --pin --length=
  assert_must_specify_value --length=
}

@test "bashword --pin --count COUNT: generates the given number of PINs" {
  _assert_results() {
    assert_output_lines_match 3 "^[0-9]{4}$"
    assert_success
  }

  run bashword --pin --count 3
  _assert_results

  run bashword --pin --count=3
  _assert_results

  run bashword --pin -c 3
  _assert_results

  run bashword --pin -c3
  _assert_results
}

@test "bashword --pin --count requires a value" {
  run bashword --pin --count=
  assert_must_specify_value --count=

  run bashword --pin --count
  assert_must_specify_value --count

  run bashword --pin -c
  assert_must_specify_value -c
}

@test "BASHWORD_DEFAULT_PASSWORD_LENGTH sets a default password length" {
  BASHWORD_DEFAULT_PASSWORD_LENGTH=30 run bashword
  assert_equal 30 "${#output}"
  assert_success
}

@test "BASHWORD_DEFAULT_PASSPHRASE_WORD_LIST sets a default passphrase word list" {
  BASHWORD_DEFAULT_PASSPHRASE_WORD_LIST="test/fixtures/words" run bashword -p
  assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
  assert_success
}

@test "BASHWORD_DEFAULT_PASSPHRASE_MIN_WORD_LENGTH sets a default min word length" {
  BASHWORD_DEFAULT_PASSPHRASE_MIN_WORD_LENGTH=4 run bashword -p
  assert_output --regexp "^[[:alpha:]]{4,}-[[:alpha:]]{4,}-[[:alpha:]]{4,}$"
  assert_success
}

@test "BASHWORD_DEFAULT_PASSPHRASE_MAX_WORD_LENGTH sets a default max word length" {
  BASHWORD_DEFAULT_PASSPHRASE_MAX_WORD_LENGTH=6 run bashword -p
  assert_output --regexp "^[[:alpha:]]{5,6}-[[:alpha:]]{5,6}-[[:alpha:]]{5,6}$"
  assert_success
}

@test "BASHWORD_DEFAULT_PASSPHRASE_WORD_COUNT sets a default word count" {
  BASHWORD_DEFAULT_PASSPHRASE_WORD_COUNT=4 run bashword -p
  assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
  assert_success
}

@test "BASHWORD_DEFAULT_PASSPHRASE_DELIMITER sets a default word delimiter" {
  BASHWORD_DEFAULT_PASSPHRASE_DELIMITER=: run bashword -p
  assert_output --regexp "^[[:alpha:]]{5,8}:[[:alpha:]]{5,8}:[[:alpha:]]{5,8}$"
  assert_success
}

@test "BASHWORD_DEFAULT_PIN_LENGTH sets a default word delimiter" {
  BASHWORD_DEFAULT_PIN_LENGTH=5 run bashword -P
  assert_equal 5 "${#output}"
  assert_success
}
