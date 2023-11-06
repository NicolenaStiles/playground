A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

### Day 5
I had to learn some important shit about how Dart handles splitting strings parsed with Regular Expressions.
- A non-empty match at the start or end of the string, or after another match, is not treated specially, and will introduce empty substrings in the result
`https://api.flutter.dev/flutter/dart-core/String/split.html`
`https://api.flutter.dev/flutter/dart-core/RegExp-class.html`
