#random collections of questionably useful bash bits

# Is string A in space-separated list B?
a_in_b() {
  test -n "$(echo "$2" | grep '\(^\| \+\)'"${1}"'\( \+\|$\)')"
}

# Is string A in comma-separated list B?
a_in_b_comma_separated() {
  test -n "$(echo "$2" | grep '\(^\|,\) *'"${1}"' *\(,\|$\)')"
}

#ubiquitous debug function
debug() {
  if [ -n "${DEBUG:-}" ]; then
    echo "DEBUG: $*" >&2
  fi
}
