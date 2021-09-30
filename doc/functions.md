# `checkFlags(value, test, all)`: bool
* `value` (integer): The value to test
* `test` (integer): The test to pass or fail
* `all` (bool): Whether all bits from `test` must be satisfied

Compares `value` and `test` as bitfields, returning `false` if `value` doesn't have any `1`s in common with `test`, and `true` otherwise.

If `all` is set, `value` must have at least all `1`s from `test` (though may have more) for a `true` result.

---

# `median(a, b, c)`: number
* `a` (number): The first number to test
* `b` (number): The second number to test
* `c` (number): The third number to test

Compares `a`, `b`, and `c`; returns the median value of the three.

---

# `splitToList(str)`: table
* `str` (string): The string to split
* `sep` (string): The characters upon which to split `str`; can include pattern-escaped characters; defaults to `"%s"`.

Splits a string at its spaces (or `sep`) into a table of one-word strings. For example, `"Hello world"` becomes `{"Hello", "world"}`.

---

# `splitToSet(str)`: table
* `str` (string): The string to split
* `sep` (string): The characters upon which to split `str`; can include pattern-escaped characters; defaults to `"%s"`
* `del` (string): The string upon which to split an entry from its key; defaults to `":"`; can include pattern-escaped characters
* `def` (any): The value given to keys that do not include `del`. Defaults to `true`.

Splits a string at its spaces (or `sep`) into a table, where each word from the string is split again at a colon (or `del`) into a key/value, or treated as a key with value `true` (or `def`). For example, `"Hello:3 world"` becomes `{Hello = "3", world = true}`.