load test_helper/bats-support/load
load test_helper/bats-assert/load

setup() {
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"

  # make executables in bin/ and test/bin visible to PATH
  PATH="$DIR/../bin:$DIR/../test/bin:$PATH"
}

# shellcheck disable=SC2154
assert_characters() {
  local charset="$1" count="$2"

  assert_output --regexp "$charset"

  if [[ "$count" ]]; then
    assert_equal "$count" \
      "$(grep -E -o "$charset" <<< "$output" | awk 'END { print NR }')"
  fi
}
