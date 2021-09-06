# Load bats-support/bats-assert
load test_helper/bats-support/load
load test_helper/bats-assert/load

# Run on test suite setup
setup() {
  # get the containing directory of this file use $BATS_TEST_FILENAME instead
  # of ${BASH_SOURCE[0]} or $0, as those will point to the bats executable's
  # location or the preprocessed file respectively
  DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"

  # make executables in bin/ and test/bin visible to PATH
  PATH="$DIR/../bin:$DIR/../test/bin:$PATH"
}

# Asserts that $output matches the given pattern
#
# $1 - pattern
# $2 - optional count to check
#
# shellcheck disable=SC2154
assert_characters() {
  local charset="$1" count="$2"

  assert_output --regexp "$charset"

  if [[ "$count" ]]; then
    assert_equal "$count" \
      "$(grep -E -o "$charset" <<< "$output" | awk 'END { print NR }')"
  fi
}

# Asserts that the previous command failed (i.e. exited >0) due to the given
# value being missing
#
# $1 - the name of the value that is missing
assert_must_specify_value() {
  assert_failure
  assert_output "Must specify value for '$1'"
}

# Asserts that each line matches the given pattern
#
# $1 - expected line count
# $2 - pattern to match
#
# shellcheck disable=SC2154
assert_output_lines_match() {
  local expected_line_count="$1" match_pattern="$2" i=0

  assert_equal "${#lines[*]}" "$expected_line_count"

  for (( i=0; i < ${#lines[*]}; i++ )); do
    echo "${lines[$i]}" | grep -E -q "$match_pattern" ||
      fail "line $i: ${lines[$i]} didn't match expression"
  done
}
