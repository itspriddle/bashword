load test_helper

@test "bashword: generates a 20 character password with letters, numbers, and symbols by default" {
  run bashword

  assert_output --regexp "^[[:alnum:][:punct:]]{20}$"
  assert_success
}

@test "bashword --length LENGTH: generates a password of the specified length" {
  run bashword --length 35

  assert_output --regexp "^[[:alnum:][:punct:]]{35}$"
  assert_success
}

@test "bashword --symbols: generates a password with at least one symbol" {
  run bashword --symbols

  assert_output --regexp "[[:punct:]]"
  assert_success
}

@test "bashword --numbers: generates a password with at least one number" {
  run bashword --numbers

  assert_output --regexp "[[:digit:]]"
  assert_success
}

@test "bashword --no-symbols: generates a password with no symbols" {
  run bashword --no-symbols
  assert_output --regexp "^[^[:punct:]]+$"
  assert_success
}

@test "bashword --no-symbols: generates a password with no numbers" {
  run bashword --no-numbers

  assert_output --regexp "^[^[:digit:]]+$"
  assert_success
}

@test "bashword --count COUNT: generates multiple passwords" {
  run bashword --count 3

  assert [ "${#lines[*]}" -eq 3 ]

  echo "${lines[0]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
    fail "line 0: ${lines[0]} didn't match expression"

  echo "${lines[1]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
    fail "line 1: ${lines[1]} didn't match expression"

  echo "${lines[2]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
    fail "line 2: ${lines[2]} didn't match expression"

  assert_success
}

@test "bashword --passphrase: generates a passphrase with 3 5-8 character words by default" {
  run bashword --passphrase

  assert_output --regexp "^[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}$"
  assert_success
}

@test "bashword --passphrase --length LENGTH: generates a passphrase with the specified number of words" {
  run bashword --passphrase --length 4
  assert_output --regexp "^[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}$"
  assert_success
}

@test "bashword --passphrase --word-length LENGTH: generates a passphrase with words of the exact length specified" {
  run bashword --passphrase --word-length 6

  assert_output --regexp "^[[:lower:]]{6}-[[:lower:]]{6}-[[:lower:]]{6}$"
  assert_success
}

@test "bashword --passphrase --max-word-length LENGTH --min-word-length LENGTH: generates a passphrase with words of the given min/max lengths" {
  run bashword --passphrase --max-word-length 10 --min-word-length 5

  assert_output --regexp "^[[:lower:]]{5,10}-[[:lower:]]{5,10}-[[:lower:]]{5,10}$"
  assert_success
}

@test "bashword --passphrase --upcase: upcases one word" {
  run bashword --passphrase --upcase

  assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
  assert_output --regexp "-?[[:upper:]]{5,8}-?"
  assert_success
}

@test "bashword --passphrase --delimiter CHAR: sets the given character as the delimiter" {
  run bashword --passphrase --delimiter ":"

  assert_output --regexp "^[[:alpha:]]{5,8}:[[:alpha:]]{5,8}:[[:alpha:]]{5,8}$"
  assert_success
}

@test "bashword --passphrase --count COUNT: generates the given number of passphrases" {
  run bashword --passphrase --count 3

  assert [ "${#lines[*]}" -eq 3 ]
  assert_success

  echo "${lines[0]}" |
    grep -E -q "^[[:lower:]]{5,10}-[[:lower:]]{5,10}-[[:lower:]]{5,10}$" ||
    fail "line 0: ${lines[0]} didn't match expression"

  echo "${lines[1]}" |
    grep -E -q "^[[:lower:]]{5,10}-[[:lower:]]{5,10}-[[:lower:]]{5,10}$" ||
    fail "line 1: ${lines[1]} didn't match expression"

  echo "${lines[2]}" |
    grep -E -q "^[[:lower:]]{5,10}-[[:lower:]]{5,10}-[[:lower:]]{5,10}$" ||
    fail "line 1: ${lines[2]} didn't match expression"

  assert_success
}

@test "bashword --pin: generates a numeric PIN 4 characters long by default" {
  run bashword --pin

  assert_output --regexp "^[0-9]{4}$"
  assert_success
}

@test "bashword --pin --length LENGTH: generates a PIN of the given length" {
  run bashword --pin --length 6

  assert_output --regexp "^[0-9]{6}$"
  assert_success
}

@test "bashword --pin --count COUNT: generates the given number of PINs" {
  run bashword --pin --count 3

  assert [ "${#lines[*]}" -eq 3 ]

  echo "${lines[0]}" | grep -E -q "^[0-9]{4}$" ||
    fail "line 0: ${lines[0]} didn't match expression"

  echo "${lines[1]}" | grep -E -q "^[0-9]{4}$" ||
    fail "line 1: ${lines[1]} didn't match expression"

  echo "${lines[2]}" | grep -E -q "^[0-9]{4}$" ||
    fail "line 2: ${lines[2]} didn't match expression"

  assert_success
}
