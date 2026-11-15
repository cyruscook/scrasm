# String encryption

WASM modules sometimes utilise a feature known as "JS String Builtins". When used, a WASM module can import string constants from a customisable namespace, e.g.:
```
(module
  (global (import "strings-namespace" "my string constant") (ref extern))
)
```

WASM modules using this feature won't have their strings encrypted by our data encryption transformer, so we need to handle this case separately, but following the same principles.

We replace the global with a default-null reference. We add one data entry containing an encryption key, and another data entry for every string, containing the string in UTF-16 form, encrypted with the key. Then we run a custom function when the module initialises, decrypting each string constant, converting them to JS Strings using an imported fromCharCodeArray function, and then storing the reference back in the original global.

The fromCharCodeArray function is provided by the JS Strings Builtin feature, this is its definition:

```
/// Convert the specified range of a mutable i16 array into a String,
/// treating each i16 as an unsigned 16-bit char code.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the array.
///
/// NOTE: This function only takes a mutable i16 array defined in its own
/// recursion group.
///
/// If this is an issue for toolchains, we can look into how to relax the
/// function type while still maintaining good performance.
func fromCharCodeArray(
  array: (ref null (array (mut i16))),
  start: i32,
  end: i32
) -> (ref extern)
{
  // NOTE: `start` and `end` are interpreted as signed 32-bit integers when
  // converted to JS values using standard conversions. Reinterpret them as
  // unsigned here.
  start >>>= 0;
  end >>>= 0;

  if (array === null)
    trap();

  if (start > end ||
      end > array_len(array))
    trap();

  let result = "";
  for(let i = start; i < end; i++) {
    let charCode = array_i16_get(array, i);
    result += String.fromCharCode(charCode);
  }
  return result;
}
```
