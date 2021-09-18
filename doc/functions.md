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

Splits a string at its spaces into a table of one-word strings. For example, `"Hello world"` becomes `{"Hello", "world"}`.

---

# `splitToSet(str)`: table
* `str` (string): The string to split

Splits a string at its spaces into a table, where each word from the string is a key with value `true`. For example, `"Hello world"` becomes `{Hello = true, world = true}`.