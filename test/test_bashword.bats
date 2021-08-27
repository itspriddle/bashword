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

  run bashword -l 35
  _assert_results

  run bashword -l35
  _assert_results
}

@test "bashword --symbols: generates a password with at least one symbol" {
  _assert_results() {
    assert_output --regexp "[[:punct:]]"
    assert_success
  }

  run bashword --symbols
  _assert_results

  run bashword -s
  _assert_results
}

@test "bashword --numbers: generates a password with at least one number" {
  _assert_results() {
    assert_output --regexp "[[:digit:]]"
    assert_success
  }

  run bashword --numbers
  _assert_results

  run bashword -n
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
}

@test "bashword --count COUNT: generates multiple passwords" {
  _assert_results() {
    assert_equal "${#lines[*]}" 3

    echo "${lines[0]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
      fail "line 0: ${lines[0]} didn't match expression"

    echo "${lines[1]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
      fail "line 1: ${lines[1]} didn't match expression"

    echo "${lines[2]}" | grep -E -q "^[[:alnum:][:punct:]]{20}$" ||
      fail "line 2: ${lines[2]} didn't match expression"

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

@test "bashword --passphrase: generates a passphrase with 3 5-8 character words by default" {
  _assert_results() {
    assert_output --regexp "^[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase
  _assert_results

  run bashword -p
  _assert_results
}

@test "bashword --passphrase --length LENGTH: generates a passphrase with the specified number of words" {
  _assert_results() {
    assert_output --regexp "^[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}-[[:lower:]]{5,8}$"
    assert_success
  }

  run bashword --passphrase --length 4
  _assert_results

  run bashword --passphrase --length=4
  _assert_results

  run bashword -p -l 4
  _assert_results

  run bashword -p -l4
  _assert_results
}

@test "bashword --passphrase --word-length LENGTH: generates a passphrase with words of the exact length specified" {
  _assert_results() {
    assert_output --regexp "^[[:lower:]]{6}-[[:lower:]]{6}-[[:lower:]]{6}$"
    assert_success
  }

  run bashword --passphrase --word-length 6
  _assert_results

  run bashword --passphrase --word-length=6
  _assert_results

  run bashword --passphrase -L 6
  _assert_results

  run bashword --passphrase -L6
  _assert_results
}

@test "bashword --passphrase --max-word-length LENGTH generates a passphrase with words of the given max lengths" {
  _assert_results() {
    assert_output --regexp "^[[:lower:]]{1,10}-[[:lower:]]{1,10}-[[:lower:]]{1,10}$"
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

@test "bashword --passphrase --min-word-length LENGTH generates a passphrase with words of the given min lengths" {
  _assert_results() {
    assert_output --regexp "^[[:lower:]]{5,}-[[:lower:]]{5,}-[[:lower:]]{5,}$"
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

@test "bashword --passphrase --upcase: upcases one word" {
  _assert_results() {
    assert_output --regexp "^[[:alpha:]]{5,8}-[[:alpha:]]{5,8}-[[:alpha:]]{5,8}$"
    assert_output --regexp "-?[[:upper:]]{5,8}-?"
    assert_success
  }

  run bashword --passphrase --upcase
  _assert_results

  run bashword --passphrase -U
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

@test "bashword --passphrase --count COUNT: generates the given number of passphrases" {
  _assert_results() {
    assert_equal "${#lines[*]}" 3

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

  run bashword --passphrase --count 3
  _assert_results

  run bashword --passphrase --count=3
  _assert_results

  run bashword --passphrase -c 3
  _assert_results

  run bashword --passphrase -c3
  _assert_results
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

  run bashword --pin -l6
  _assert_results

  run bashword --pin -l 6
  _assert_results
}

@test "bashword --pin --count COUNT: generates the given number of PINs" {
  _assert_results() {
    assert_equal "${#lines[*]}" 3

    echo "${lines[0]}" | grep -E -q "^[0-9]{4}$" ||
      fail "line 0: ${lines[0]} didn't match expression"

    echo "${lines[1]}" | grep -E -q "^[0-9]{4}$" ||
      fail "line 1: ${lines[1]} didn't match expression"

    echo "${lines[2]}" | grep -E -q "^[0-9]{4}$" ||
      fail "line 2: ${lines[2]} didn't match expression"

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
