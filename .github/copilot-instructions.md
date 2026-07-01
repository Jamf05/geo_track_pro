# Copilot Instructions — Flutter / Dart Lint Rules

> This document explains, rule by rule, the lint configuration defined in `analysis_options.yaml` for this project. It combines two rule sources:
>
> 1. **DCM (`dart_code_linter` / Dart Code Metrics)** — a static analysis plugin with rules not available in the core Dart SDK linter. Official docs: <https://dcm.dev/docs/rules/>.
> 2. **Dart/Flutter core linter** — rules shipped with the Dart SDK and the `flutter_lints` recommended set. Official docs: <https://dart.dev/tools/linter-rules>.
>
> When GitHub Copilot (or any AI assistant) suggests code for this repository, it **must** respect every rule below. For each rule you will find: what it checks, why it exists, a ✅ compliant example and a ❌ non-compliant example.

---

## 1. DCM Anti-patterns

DCM anti-patterns are composite checks that look at a declaration's overall shape rather than a single syntactic construct. Docs: <https://dcm.dev/docs/rules/dart/anti-patterns/>.

### `long-parameter-list`
**What it checks:** Flags functions/methods/constructors whose parameter count exceeds the configured threshold (here, controlled indirectly by the `number-of-parameters: 4` metric).
**Why:** Long parameter lists are hard to read, easy to call with arguments in the wrong order, and signal that a class/data object should be extracted.

✅ Correct:
```dart
class CreateUserParams {
  const CreateUserParams({
    required this.name,
    required this.email,
    required this.age,
    required this.country,
  });

  final String name;
  final String email;
  final int age;
  final String country;
}

User createUser(CreateUserParams params) { ... }
```

❌ Incorrect:
```dart
User createUser(String name, String email, int age, String country, String city, String phone) {
  // 6 positional parameters — hard to call correctly, hard to read at the call site
}
```

### `long-method`
**What it checks:** Flags methods/functions that exceed the configured length or complexity (tied to `source-lines-of-code: 250`, `cyclomatic-complexity: 20`, `maximum-nesting-level: 5`).
**Why:** Long methods usually do more than one thing, are hard to test in isolation, and hide bugs in deep nesting.

✅ Correct:
```dart
void submitOrder(Order order) {
  _validate(order);
  _charge(order);
  _notifyUser(order);
}

void _validate(Order order) { ... }
void _charge(Order order) { ... }
void _notifyUser(Order order) { ... }
```

❌ Incorrect:
```dart
void submitOrder(Order order) {
  // 300 lines mixing validation, payment, logging, notifications,
  // deeply nested ifs and try/catch blocks all in one method
}
```

---

## 2. DCM Metrics (thresholds referenced by the anti-patterns above)

Docs: <https://dcm.dev/docs/rules/dart/metrics/>. These are not "rules" you write code against directly — they configure the thresholds used by `long-method`, `long-parameter-list`, and DCM's metrics reports (excluded from `test/**` via `metrics-exclude`).

| Metric | Value | Meaning |
|---|---|---|
| `source-lines-of-code` | 250 | Max lines of code per function/method body. |
| `number-of-parameters` | 4 | Max parameters per function/method/constructor. |
| `number-of-methods` | 10 | Max public methods per class before it's considered doing too much. |
| `maximum-nesting-level` | 5 | Max nesting depth of blocks (`if`, `for`, `while`, etc.). |
| `cyclomatic-complexity` | 20 | Max number of independent paths through a method. |

✅ Correct (low nesting/complexity):
```dart
bool isEligible(User user) {
  if (!user.isActive) return false;
  if (user.age < 18) return false;
  return user.hasVerifiedEmail;
}
```

❌ Incorrect (deep nesting, high complexity):
```dart
bool isEligible(User user) {
  if (user.isActive) {
    if (user.age >= 18) {
      if (user.hasVerifiedEmail) {
        if (user.country == 'US') {
          if (user.hasAcceptedTerms) {
            // 5+ nested levels
            return true;
          }
        }
      }
    }
  }
  return false;
}
```

---

## 3. DCM Rules

Docs index: <https://dcm.dev/docs/rules/>. Each entry below matches an item in `dart_code_linter.rules`.

### `prefer-match-file-name` (excluded on `test/**`)
**What it checks:** The file name should match the name of the single top-level public declaration it contains (e.g. `user_repository.dart` should declare `UserRepository`).
**Why:** Makes navigation and IDE search predictable.

✅ Correct: file `user_repository.dart`
```dart
class UserRepository { ... }
```

❌ Incorrect: file `repo.dart`
```dart
class UserRepository { ... } // file name doesn't reflect the class name
```

### `prefer-first-or-null`
**What it checks:** Suggests `list.firstOrNull` instead of `list.isNotEmpty ? list.first : null` patterns.
**Why:** Safer, more concise, avoids exceptions used for control flow.

✅ Correct:
```dart
final firstAdmin = users.firstOrNull;
```

❌ Incorrect:
```dart
final firstAdmin = users.isNotEmpty ? users.first : null;
```

### `avoid-border-all`
**What it checks:** Flags `Border.all(...)` when only some sides need styling.
**Why:** `Border.all` allocates all four sides even if only one is used; prefer an explicit `Border(...)` per side.

✅ Correct:
```dart
const border = Border(bottom: BorderSide(color: Colors.grey, width: 1));
```

❌ Incorrect:
```dart
const border = Border.all(color: Colors.grey, width: 1); // only the bottom border is needed
```

### `avoid-wrapping-in-padding`
**What it checks:** Flags a `Padding` widget wrapping a widget that already exposes a `padding` parameter (e.g. `Container`, `Card`).
**Why:** Avoids redundant widget nesting.

✅ Correct:
```dart
Container(padding: const EdgeInsets.all(8), child: const Text('Hello'));
```

❌ Incorrect:
```dart
Padding(padding: const EdgeInsets.all(8), child: Container(child: const Text('Hello')));
```

### `no-blank-line-before-single-return`
**What it checks:** Disallows a blank line right before a lone `return` statement.
**Why:** Keeps trivial getters/functions visually compact.

✅ Correct:
```dart
String get fullName {
  return '$firstName $lastName';
}
```

❌ Incorrect:
```dart
String get fullName {

  return '$firstName $lastName';
}
```

### `avoid-expanded-as-spacer`
**What it checks:** Flags an empty `Expanded(child: SizedBox())` used only to push siblings apart.
**Why:** `Spacer()` exists exactly for this purpose.

✅ Correct:
```dart
Row(children: [const Icon(Icons.star), const Spacer(), const Icon(Icons.settings)]);
```

❌ Incorrect:
```dart
Row(children: [const Icon(Icons.star), const Expanded(child: SizedBox()), const Icon(Icons.settings)]);
```

### `prefer-trailing-comma` (`severity: none` — disabled)
Would require a trailing comma on multi-line argument/parameter lists. Disabled in this project, so it is never reported.

### `prefer-single-quotes`
**What it checks:** Enforces `'single quotes'` over `"double quotes"` for string literals.
**Why:** Matches the official Dart style guide (Effective Dart).

✅ Correct: `final greeting = 'Hello, world!';`

❌ Incorrect: `final greeting = "Hello, world!";`

### `avoid-passing-async-when-sync-expected` (excluded on `test/**`)
**What it checks:** Flags an `async` function passed where a synchronous callback type is expected (e.g. `onPressed`).
**Why:** The framework won't await it, so errors can be silently lost.

✅ Correct:
```dart
onPressed: () {
  unawaited(_submit());
},
```

❌ Incorrect:
```dart
onPressed: () async {
  await _submit(); // caller expects a synchronous VoidCallback
},
```

### `avoid-ignoring-return-values` (`severity: none` — disabled)
Would flag discarding a meaningful return value (e.g. a `Future`). Disabled in this project.

### `prefer-using-list-view`
**What it checks:** Suggests `ListView.builder` instead of `Column` + `.map().toList()` inside a `SingleChildScrollView` for lists.
**Why:** Lazy building is far more efficient for long/unbounded lists.

✅ Correct:
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
);
```

❌ Incorrect:
```dart
SingleChildScrollView(
  child: Column(children: items.map((item) => ListTile(title: Text(item))).toList()),
);
```

### `prefer-extracting-callbacks`
**What it checks:** Flags non-trivial inline closures passed directly as widget callbacks, suggesting extraction into a named method.
**Why:** Inline closures are rebuilt on every `build()` and hurt readability.

✅ Correct:
```dart
void _handleTap() { /* logic */ }
// ...
GestureDetector(onTap: _handleTap, child: const Text('Tap'));
```

❌ Incorrect:
```dart
GestureDetector(
  onTap: () { /* several lines of logic inline */ },
  child: const Text('Tap'),
);
```

### `avoid-unnecessary-setstate`
**What it checks:** Flags `setState` calls whose closure doesn't actually mutate any field read by `build`.
**Why:** Unnecessary rebuilds waste performance.

✅ Correct: `setState(() { _counter++; });`

❌ Incorrect:
```dart
setState(() {
  print('tapped'); // no field mutated
});
```

### `always-remove-listener`
**What it checks:** Ensures every `addListener` has a matching `removeListener` in `dispose()`.
**Why:** Prevents memory leaks and calls into disposed objects.

✅ Correct:
```dart
@override
void initState() {
  super.initState();
  _controller.addListener(_onChange);
}

@override
void dispose() {
  _controller.removeListener(_onChange);
  _controller.dispose();
  super.dispose();
}
```

❌ Incorrect:
```dart
@override
void initState() {
  super.initState();
  _controller.addListener(_onChange); // never removed
}
```

### `member-ordering`
**What it checks:** Enforces a declared ordering of class members. This project configures:
- **Widget order:** `dispose` → `didUpdateWidget` → `didChangeDependencies` → `initState` → `build` → constructor.
- **General order:** `dispose`/`close` → private fields → public fields → constructors → (remaining members).

**Why:** Consistent ordering makes every file navigable the same way across the codebase.

✅ Correct:
```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}
```

❌ Incorrect:
```dart
class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) => const SizedBox(); // build before initState

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() { // dispose should come first
    super.dispose();
  }
}
```

### `format-comment` (`only-doc-comments: true`)
**What it checks:** Enforces formatting only on doc comments (`///`); regular `//` comments are ignored.
**Why:** Doc comments appear in IDE tooltips and generated docs, so they deserve consistent formatting.

✅ Correct:
```dart
/// Returns the full name of the user.
String get fullName => '$firstName $lastName';
```

❌ Incorrect:
```dart
/// returns the full name of the user  <- not capitalized, no period
String get fullName => '$firstName $lastName';
```

### `prefer-moving-to-variable`
**What it checks:** Flags a non-trivial expression repeated multiple times in the same scope.
**Why:** Avoids duplicated computation and improves readability.

✅ Correct:
```dart
final area = width * height;
print(area);
return area > 100;
```

❌ Incorrect:
```dart
print(width * height);
return (width * height) > 100; // recomputed
```

### `prefer-immediate-return`
**What it checks:** Flags assigning to a variable then immediately returning it, instead of returning the expression directly.
**Why:** Removes an unnecessary intermediate variable.

✅ Correct:
```dart
int calculateTotal() {
  return price * quantity;
}
```

❌ Incorrect:
```dart
int calculateTotal() {
  final total = price * quantity;
  return total;
}
```

### `prefer-conditional-expressions`
**What it checks:** Suggests a ternary instead of an `if/else` that only assigns to the same variable or returns a value.
**Why:** More concise for simple binary choices.

✅ Correct: `final label = isActive ? 'Active' : 'Inactive';`

❌ Incorrect:
```dart
String label;
if (isActive) {
  label = 'Active';
} else {
  label = 'Inactive';
}
```

### `no-magic-number`
**What it checks:** Flags numeric literals used directly in code instead of a named constant.
**Why:** Magic numbers hide intent and are hard to update consistently.

✅ Correct:
```dart
const maxRetryCount = 3;
if (attempts >= maxRetryCount) { ... }
```

❌ Incorrect: `if (attempts >= 3) { ... } // what does 3 mean?`

### `no-equal-then-else`
**What it checks:** Flags `if/else` statements whose two branches are identical.
**Why:** Identical branches mean the condition is dead code or a bug.

✅ Correct: `final message = isError ? 'Something failed' : 'All good';`

❌ Incorrect:
```dart
if (isError) {
  showMessage('Done');
} else {
  showMessage('Done'); // same as the "then" branch
}
```

### `no-empty-block`
**What it checks:** Flags empty code blocks (`{}`) without a comment explaining the intent.
**Why:** Empty blocks are often leftover debugging code or silently-swallowed errors.

✅ Correct:
```dart
try {
  await _save();
} catch (e) {
  // Intentionally ignored: retried by the background sync worker.
}
```

❌ Incorrect:
```dart
try {
  await _save();
} catch (e) {} // silently swallowed
```

### `no-boolean-literal-compare`
**What it checks:** Flags comparisons like `if (isValid == true)`.
**Why:** Booleans should be used directly.

✅ Correct: `if (isValid) { ... }` / `if (!isValid) { ... }`

❌ Incorrect: `if (isValid == true) { ... }`

### `newline-before-return` (`severity: none` — disabled)
Would require a blank line before a `return` preceded by other statements. Disabled in this project.

### `missing-test-assertion`
**What it checks:** Flags `test(...)`/`testWidgets(...)` blocks with no `expect(...)` call.
**Why:** A test with no assertions always "passes" and gives false confidence.

✅ Correct:
```dart
test('sum adds two numbers', () {
  expect(sum(2, 3), 5);
});
```

❌ Incorrect:
```dart
test('sum adds two numbers', () {
  sum(2, 3); // no expect() — can never fail
});
```

### `avoid-unused-parameters` (`severity: none` — disabled)
Would flag parameters that are never referenced. Disabled in this project (useful for interface implementations/callbacks).

### `avoid-unnecessary-conditionals`
**What it checks:** Flags conditionals whose result is statically known.
**Why:** Dead/redundant conditions add noise.

✅ Correct:
```dart
void greet(String name) {
  print('Hello, $name');
}
```

❌ Incorrect:
```dart
void greet(String name) {
  if (name != null) { // name is non-nullable — always true
    print('Hello, $name');
  }
}
```

### `avoid-unnecessary-type-casts`
**What it checks:** Flags `as SomeType` when the expression is already statically that type.
**Why:** Redundant casts add noise and can mask a real mismatch.

✅ Correct: `int total = computeTotal();`

❌ Incorrect: `int total = computeTotal() as int; // already returns int`

### `avoid-nested-conditional-expressions`
**What it checks:** Flags a ternary nested inside another ternary.
**Why:** Nested ternaries are hard to read.

✅ Correct:
```dart
String describe(int score) {
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  return 'C';
}
```

❌ Incorrect: `final grade = score >= 90 ? 'A' : (score >= 80 ? 'B' : 'C');`

### `avoid-returning-widgets`
**What it checks:** Flags methods (other than `build`) that return a `Widget`, suggesting a dedicated `Widget` subclass instead.
**Why:** Widget classes benefit from Flutter's diffing/`const` optimizations; methods don't.

✅ Correct:
```dart
class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) => const Text('Header');
}
```

❌ Incorrect:
```dart
Widget _buildHeader() => const Text('Header'); // widget-returning method
```

### `avoid-dynamic`
**What it checks:** Flags explicit use of the `dynamic` type.
**Why:** `dynamic` disables static type checking; prefer `Object?` or a concrete type.

✅ Correct: `void log(Object? value) { ... }`

❌ Incorrect: `void log(dynamic value) { ... }`

### `avoid-non-null-assertion`
**What it checks:** Flags the `!` null-assertion operator.
**Why:** `!` throws at runtime if the value is actually `null`.

✅ Correct: `final name = user?.name ?? 'Unknown';`

❌ Incorrect: `final name = user!.name; // crashes if user is null`

### `prefer-last`
**What it checks:** Suggests `list.last` instead of `list[list.length - 1]`.

✅ Correct: `final lastItem = items.last;`

❌ Incorrect: `final lastItem = items[items.length - 1];`

### `prefer-first`
**What it checks:** Suggests `list.first` instead of `list[0]`.

✅ Correct: `final firstItem = items.first;`

❌ Incorrect: `final firstItem = items[0];`

### `prefer-correct-type-name` (`min-length: 3`, `max-length: 35`)
**What it checks:** Class/type names must be between 3 and 35 characters.

✅ Correct: `class UserRepository { ... }`

❌ Incorrect: `class X { ... }` (too short) or an overly long 60-character class name.

### `prefer-correct-test-file-name`
**What it checks:** Test files must end with `_test.dart`.

✅ Correct: `user_repository_test.dart`

❌ Incorrect: `user_repository_tests.dart`

### `prefer-correct-identifier-length` (`min-identifier-length: 3`, `max-identifier-length: 35`)
**What it checks:** Variable/parameter/field names must be between 3 and 35 characters.

✅ Correct: `final userCount = users.length;`

❌ Incorrect: `final uc = users.length; // unclear abbreviation`

### `prefer-async-await`
**What it checks:** Suggests `async`/`await` instead of `.then()`/`.catchError()` chains.

✅ Correct:
```dart
Future<void> loadData() async {
  try {
    final data = await fetchData();
    _process(data);
  } catch (e) {
    _handleError(e);
  }
}
```

❌ Incorrect:
```dart
void loadData() {
  fetchData().then((data) => _process(data)).catchError((e) => _handleError(e));
}
```

### `double-literal-format`
**What it checks:** Enforces `1.0` style over `1.` or `.5`.

✅ Correct: `const double price = 1.0;`

❌ Incorrect: `const double price = 1.;`

### `avoid-unrelated-type-assertions`
**What it checks:** Flags `is`/`as` checks between two types with no possible common subtype.
**Why:** Such assertions can never succeed — almost certainly a bug.

✅ Correct: `if (value is String) { ... }`

❌ Incorrect: `if (value is String && value is int) { ... } // impossible`

### `avoid-unnecessary-type-assertions`
**What it checks:** Flags `is` checks that are statically guaranteed true given the declared type.

✅ Correct:
```dart
void handle(String value) {
  print(value.toUpperCase());
}
```

❌ Incorrect:
```dart
void handle(String value) {
  if (value is String) { // always true
    print(value.toUpperCase());
  }
}
```

---

## 4. Analyzer configuration

Docs: <https://dart.dev/tools/analysis>.

### `analyzer.plugins: [dart_code_linter]`
Registers the DCM plugin so all rules in section 3 above run as part of `dart analyze` / IDE analysis.

### `analyzer.exclude`
```yaml
exclude:
  - "**.g.dart"
  - "**.mocks.dart"
```
**What it does:** Excludes generated files (`build_runner`/`json_serializable`/`freezed` output in `*.g.dart`, and Mockito-generated `*.mocks.dart`) from analysis entirely.
**Why:** Generated code is not hand-written and shouldn't be linted or trigger warnings that developers can't directly fix.

### `analyzer.errors` — severity overrides
```yaml
errors:
  todo: warning
  use_build_context_synchronously: warning
  use_super_parameters: warning
  no_leading_underscores_for_local_identifiers: warning
  deprecated_member_use_from_same_package: warning
  deprecated_member_use: warning
  use_setters_to_change_properties: ignore
  parameter_assignments: error
  missing_return: error
  missing_required_param: error
```
This block **re-maps the severity** of specific diagnostics (it does not enable/disable the underlying lint itself, which is separately controlled under `linter.rules`). Docs on severity overrides: <https://dart.dev/tools/analysis#customizing-analysis-rules>.

- **`todo: warning`** — `// TODO` comments are surfaced as warnings (visible in CI/IDE) instead of silent hints, so they aren't forgotten.
- **`use_build_context_synchronously: warning`** — Using a `BuildContext` after an `await` without checking `context.mounted` is elevated to a warning because it can crash the app or update a disposed widget.
  ✅ `if (!context.mounted) return; Navigator.of(context).pop();`
  ❌ `await Future.delayed(...); Navigator.of(context).pop(); // context might be stale`
- **`use_super_parameters: warning`** — Encourages Dart's super-parameter shorthand.
  ✅ `MyWidget({super.key});`
  ❌ `MyWidget({Key? key}) : super(key: key);`
- **`no_leading_underscores_for_local_identifiers: warning`** — Local variables/parameters shouldn't start with `_` (that convention is reserved for library-private members).
  ✅ `final total = compute();`
  ❌ `final _total = compute();`
- **`deprecated_member_use_from_same_package` / `deprecated_member_use`: warning** — Using an API annotated `@Deprecated(...)`, whether from this package or an external one, is surfaced as a warning so migrations aren't missed silently.
- **`use_setters_to_change_properties: ignore`** — This rule (which suggests replacing a single-field-mutating method with a setter) is fully silenced in this project; both styles are accepted.
- **`parameter_assignments: error`** — Reassigning a function parameter's value inside the function body is escalated to a build-breaking **error** (see the `parameter_assignments` lint below for examples).
- **`missing_return: error`** — A function with a non-`void`/non-`Future<void>` return type that doesn't return on all code paths is a build-breaking error.
- **`missing_required_param: error`** — Omitting a `@required`/`required` parameter at a call site is a build-breaking error.

---

## 5. `include: package:flutter_lints/flutter.yaml`

This project bases its rule set on `flutter_lints`, Google's official recommended lint set for Flutter apps, built on top of Dart's core `lints` package. Docs: <https://dart.dev/tools/linter-rules> and <https://pub.dev/packages/flutter_lints>. All rules explicitly listed under `linter.rules` below either reaffirm, extend, or override what `flutter_lints` already enables.

---

## 6. Explicit `linter.rules`

Docs for every core rule: <https://dart.dev/tools/linter-rules/RULE_NAME> (replace `RULE_NAME`).

### `use_build_context_synchronously: true`
**What it checks:** Flags using a `BuildContext` across an `async` gap (after an `await`) without verifying it's still mounted.
**Why:** The widget may have been disposed while awaiting, causing a crash or a no-op on a stale tree.

✅ Correct:
```dart
Future<void> _submit(BuildContext context) async {
  await _save();
  if (!context.mounted) return;
  Navigator.of(context).pop();
}
```

❌ Incorrect:
```dart
Future<void> _submit(BuildContext context) async {
  await _save();
  Navigator.of(context).pop(); // context might belong to a disposed widget
}
```

### `use_super_parameters: true`
**What it checks:** Suggests Dart's super-initializer parameter shorthand (`super.key`) instead of manually forwarding to `super(...)`.

✅ Correct: `const MyWidget({super.key});`

❌ Incorrect: `const MyWidget({Key? key}) : super(key: key);`

### `depend_on_referenced_packages: false`
**What it checks (when enabled):** Would require every package imported directly to be listed as a direct dependency in `pubspec.yaml` (not transitively available).
**Status in this project:** Disabled — transitive dependencies may be imported directly without a warning.

### `no_leading_underscores_for_local_identifiers: true`
**What it checks:** Local variables and parameters should not start with `_`.
**Why:** Leading underscore denotes library-privacy for top-level/class members in Dart; using it on locals is misleading.

✅ Correct: `void run() { final result = compute(); }`

❌ Incorrect: `void run() { final _result = compute(); }`

### `implementation_imports: false`
**What it checks (when enabled):** Would forbid importing a file from another package's `src/` (implementation-only) directory.
**Status in this project:** Disabled — importing `package:some_pkg/src/...` is allowed without warning.

### `overridden_fields: false`
**What it checks (when enabled):** Would flag a subclass field that shadows/overrides a superclass field of the same name.
**Status in this project:** Disabled.

### `annotate_overrides: false`
**What it checks (when enabled):** Would require `@override` on every member that overrides a superclass/interface member.
**Status in this project:** Disabled — `@override` is optional here (though still good practice).

### `prefer_relative_imports: true`
**What it checks:** Within the same package, prefer relative imports (`../models/user.dart`) over package imports (`package:app/models/user.dart`).
**Why:** Relative imports keep working if the package is renamed and are easier to move between projects.

✅ Correct: `import '../models/user.dart';`

❌ Incorrect (inside the same package): `import 'package:app/models/user.dart';`

### `unawaited_futures: true`
**What it checks:** Flags a `Future`-returning expression statement that isn't `await`ed or explicitly wrapped in `unawaited(...)`.
**Why:** Prevents accidentally losing errors from fire-and-forget async calls.

✅ Correct:
```dart
Future<void> save() async {
  await _repository.persist(data);
}
// or, if truly fire-and-forget:
unawaited(_analytics.logEvent('save'));
```

❌ Incorrect:
```dart
Future<void> save() async {
  _repository.persist(data); // Future not awaited nor marked unawaited
}
```

### `prefer_function_declarations_over_variables: false`
**What it checks (when enabled):** Would prefer `void foo() {}` over `final foo = () {};` at the top level/class level.
**Status in this project:** Disabled — assigning a function literal to a variable is allowed.

### `parameter_assignments: true` (escalated to `error` above)
**What it checks:** Flags reassigning the value of a function/method parameter inside the body.
**Why:** Reassigning parameters makes debugging harder (the "original" argument value is lost) and can be confused with mutation of the caller's variable.

✅ Correct:
```dart
int increment(int value) {
  final result = value + 1;
  return result;
}
```

❌ Incorrect:
```dart
int increment(int value) {
  value = value + 1; // reassigning the parameter — build error in this project
  return value;
}
```

### `avoid_return_types_on_setters: true`
**What it checks:** Flags a setter that explicitly declares a return type (setters must be `void` and Dart forbids/discourages annotating it).

✅ Correct: `set name(String value) { _name = value; }`

❌ Incorrect: `void set name(String value) { _name = value; }`

### `avoid_setters_without_getters: true`
**What it checks:** Flags a class defining a setter for a property with no corresponding getter.
**Why:** A write-only property is confusing and usually signals a design mistake.

✅ Correct:
```dart
String get name => _name;
set name(String value) => _name = value;
```

❌ Incorrect:
```dart
set name(String value) => _name = value; // no getter defined
```

### `unnecessary_getters_setters: true`
**What it checks:** Flags a getter/setter pair that simply reads/writes a backing field with no extra logic (could be a plain public field instead).

✅ Correct: `String name = '';`

❌ Incorrect:
```dart
String _name = '';
String get name => _name;
set name(String value) => _name = value;
```

### `unnecessary_parenthesis: true`
**What it checks:** Flags redundant parentheses around expressions.

✅ Correct: `final total = a + b * c;`

❌ Incorrect: `final total = a + (b * c);` when operator precedence already makes this unambiguous, or `final x = (a);`

### `unnecessary_overrides: true`
**What it checks:** Flags an override method that only calls `super.method(...)` with the same arguments and does nothing else.

✅ Correct: (no override at all, since the default behavior is already correct)

❌ Incorrect:
```dart
@override
void dispose() {
  super.dispose(); // adds nothing — the override is unnecessary
}
```

### `unnecessary_const: true`
**What it checks:** Flags a redundant `const` keyword when the enclosing context is already constant.

✅ Correct:
```dart
const list = [1, 2, 3];
```

❌ Incorrect:
```dart
const list = const [1, 2, 3]; // inner `const` is redundant
```

### `unnecessary_this: true`
**What it checks:** Flags `this.` when it isn't needed to disambiguate a name clash.

✅ Correct: `void setName(String value) { name = value; }`

❌ Incorrect: `void setName(String value) { this.name = value; }` (when no shadowing exists)

### `unnecessary_new: true`
**What it checks:** Flags the redundant `new` keyword (obsolete since Dart 2, where `new` is optional).

✅ Correct: `final user = User();`

❌ Incorrect: `final user = new User();`

### `empty_statements: true`
**What it checks:** Flags stray semicolons that form an empty statement.

✅ Correct:
```dart
if (isValid) {
  doSomething();
}
```

❌ Incorrect:
```dart
if (isValid); { // stray `;` creates an accidental empty statement
  doSomething();
}
```

### `empty_constructor_bodies: true`
**What it checks:** Flags a constructor with an empty `{}` body; should use `;` instead.

✅ Correct: `MyClass(this.value);`

❌ Incorrect: `MyClass(this.value) {}`

### `type_init_formals: true`
**What it checks:** Flags redundant type annotations on initializing formals (`this.x`) whose type is already known from the field declaration.

✅ Correct:
```dart
class Point {
  Point(this.x, this.y);
  final int x;
  final int y;
}
```

❌ Incorrect:
```dart
class Point {
  Point(int this.x, int this.y); // redundant type annotation
  final int x;
  final int y;
}
```

### `prefer_initializing_formals: true`
**What it checks:** Suggests `this.field` constructor shorthand instead of manually assigning a parameter to a field in the constructor body/initializer list.

✅ Correct: `MyClass(this.value);`

❌ Incorrect:
```dart
class MyClass {
  MyClass(int value) : _value = value;
  final int _value;
}
```

### `avoid_init_to_null: true`
**What it checks:** Flags explicit `= null` initializers, since fields/variables default to `null` already when nullable.

✅ Correct: `String? name;`

❌ Incorrect: `String? name = null;`

### `avoid_function_literals_in_foreach_calls: false`
**What it checks (when enabled):** Would prefer a `for` loop over `list.forEach((e) { ... })`.
**Status in this project:** Disabled — `.forEach()` with a closure is allowed.

### `prefer_collection_literals: true`
**What it checks:** Suggests collection literals (`[]`, `{}`) over constructors like `List()`, `Map()`.

✅ Correct: `final items = <String>[];`

❌ Incorrect: `final items = List<String>();`

### `prefer_interpolation_to_compose_strings: true`
**What it checks:** Suggests string interpolation over `+` concatenation.

✅ Correct: `final message = 'Hello, $name!';`

❌ Incorrect: `final message = 'Hello, ' + name + '!';`

### `slash_for_doc_comments: false`
**What it checks (when enabled):** Would require `///` doc comments instead of `/** ... */` block-style doc comments.
**Status in this project:** Disabled — both comment styles are accepted for documentation.

### `curly_braces_in_flow_control_structures: true`
**What it checks:** Requires `{}` braces on `if`, `for`, `while`, `do` bodies, even for single statements.
**Why:** Prevents the classic "dangling else" / accidental-scope bug when adding a second line later.

✅ Correct:
```dart
if (isValid) {
  doSomething();
}
```

❌ Incorrect:
```dart
if (isValid) doSomething();
```

### `directives_ordering: true`
**What it checks:** Enforces a canonical order for `import`/`export` directives (dart: SDK imports, then package imports, then relative imports, each block alphabetized).

✅ Correct:
```dart
import 'dart:async';

import 'package:flutter/material.dart';

import '../models/user.dart';
```

❌ Incorrect:
```dart
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'dart:async';
```

### `library_prefixes: true`
**What it checks:** Requires `import ... as prefix` prefixes to use `lowercase_with_underscores`.

✅ Correct: `import 'dart:math' as math;`

❌ Incorrect: `import 'dart:math' as Math;`

### `non_constant_identifier_names: true`
**What it checks:** Requires variables, parameters, and functions to use `lowerCamelCase` (not `snake_case` or `PascalCase`).

✅ Correct: `final userName = 'Ana';`

❌ Incorrect: `final user_name = 'Ana';`

### `constant_identifier_names: false`
**What it checks (when enabled):** Would require `const` variables to use `lowerCamelCase` instead of `SCREAMING_CAPS`.
**Status in this project:** Disabled — `const MAX_RETRIES = 3;` style is allowed.

### `file_names: true`
**What it checks:** Requires Dart source file names to use `lowercase_with_underscores.dart`.

✅ Correct: `user_repository.dart`

❌ Incorrect: `UserRepository.dart` or `userRepository.dart`

### `avoid_relative_lib_imports: false`
**What it checks (when enabled):** Would forbid relative imports that reach outside `lib/` into another `lib/` (e.g. `../../other_package/lib/x.dart`).
**Status in this project:** Disabled.

### `library_names: true`
**What it checks:** Requires `library` directive names to use `lowercase_with_underscores`.

✅ Correct: `library my_package.utils;`

❌ Incorrect: `library MyPackage.Utils;`

### `camel_case_types: true`
**What it checks:** Requires class/enum/typedef/mixin names to use `UpperCamelCase`.

✅ Correct: `class UserRepository { ... }`

❌ Incorrect: `class user_repository { ... }`

### `sort_child_properties_last: true`
**What it checks:** In a widget constructor call, the `child`/`children` argument should be the last one listed.
**Why:** Keeps deeply-nested widget trees readable — the nested subtree visually appears at the end.

✅ Correct:
```dart
Container(
  padding: const EdgeInsets.all(8),
  color: Colors.blue,
  child: const Text('Hi'),
);
```

❌ Incorrect:
```dart
Container(
  child: const Text('Hi'),
  padding: const EdgeInsets.all(8),
  color: Colors.blue,
);
```

### `prefer_single_quotes: true`
Same rule as DCM's `prefer-single-quotes` above, enforced at the core-linter level too — kept consistent between both linters.

✅ Correct: `'text'`   ❌ Incorrect: `"text"`

### `only_throw_errors: true`
**What it checks:** Requires `throw` to only throw instances of `Error`, `Exception`, or another `Object` intended as an error type — not raw `String`s, `null`, or arbitrary values.

✅ Correct: `throw ArgumentError('Invalid input');`

❌ Incorrect: `throw 'Invalid input';`

### `one_member_abstracts: false`
**What it checks (when enabled):** Would flag an abstract class with a single method, suggesting a function type/typedef instead.
**Status in this project:** Disabled.

### `comment_references: false`
**What it checks (when enabled):** Would require identifiers inside `[brackets]` in doc comments to resolve to a real symbol.
**Status in this project:** Disabled.

### `close_sinks: true`
**What it checks:** Flags `Sink`/`StreamController` fields that are never `.close()`d.
**Why:** Unclosed sinks leak resources.

✅ Correct:
```dart
final _controller = StreamController<int>();

@override
void dispose() {
  _controller.close();
  super.dispose();
}
```

❌ Incorrect:
```dart
final _controller = StreamController<int>(); // never closed
```

### `cancel_subscriptions: true`
**What it checks:** Flags `StreamSubscription`s that are never `.cancel()`ed.
**Why:** Uncancelled subscriptions leak memory and can call back into disposed objects.

✅ Correct:
```dart
late final StreamSubscription<int> _sub;

@override
void initState() {
  super.initState();
  _sub = _stream.listen(_onData);
}

@override
void dispose() {
  _sub.cancel();
  super.dispose();
}
```

❌ Incorrect:
```dart
_stream.listen(_onData); // subscription reference dropped, never cancelled
```

### `always_declare_return_types: true`
**What it checks:** Requires every function/method to explicitly declare a return type (no inferred/implicit `dynamic`).

✅ Correct: `int add(int a, int b) => a + b;`

❌ Incorrect: `add(int a, int b) => a + b;`

### `use_full_hex_values_for_flutter_colors: true`
**What it checks:** Requires `Color(0xFFRRGGBB)` 8-digit hex (including alpha) instead of a 6-digit value.

✅ Correct: `const color = Color(0xFF42A5F5);`

❌ Incorrect: `const color = Color(0x42A5F5);` (missing alpha channel digits)

### `sized_box_for_whitespace: true`
**What it checks:** Suggests `SizedBox` instead of an empty `Container` used purely to add fixed spacing.
**Why:** `SizedBox` is lighter-weight (no decoration/paint logic) for pure spacing.

✅ Correct: `const SizedBox(height: 16);`

❌ Incorrect: `Container(height: 16);` (used purely for spacing, no color/decoration)

### `prefer_const_literals_to_create_immutables: true`
**What it checks:** Requires collection literals passed to `const`-constructible widgets/objects to also be `const`.

✅ Correct: `const MyWidget(items: const <String>['a', 'b']);` *(or simply `const MyWidget(items: <String>['a', 'b']);` where const is inferred)*

❌ Incorrect: `const MyWidget(items: <String>['a', 'b']);` when the list itself could and should also be explicitly const-inferred consistently — i.e. mixing const/non-const unnecessarily.

### `prefer_const_declarations: true`
**What it checks:** Suggests `const` over `final` for variables whose initializer is a compile-time constant.

✅ Correct: `const maxItems = 10;`

❌ Incorrect: `final maxItems = 10;` (value is a compile-time constant, so it should be `const`)

### `prefer_const_constructors_in_immutables: true`
**What it checks:** In classes that are effectively immutable (all fields `final`), requires constructors to be marked `const` when possible.

✅ Correct:
```dart
class Point {
  const Point(this.x, this.y);
  final int x;
  final int y;
}
```

❌ Incorrect:
```dart
class Point {
  Point(this.x, this.y); // could be const — all fields are final
  final int x;
  final int y;
}
```

### `prefer_const_constructors: true`
**What it checks:** Suggests adding `const` at widget/object construction call sites when the constructor supports it.

✅ Correct: `const Text('Hello');`

❌ Incorrect: `Text('Hello');` (missing `const` even though `Text`'s constructor is const-compatible here)

### `no_logic_in_create_state: false`
**What it checks (when enabled):** Would forbid logic (other than returning the State instance) inside `createState()`.
**Status in this project:** Disabled.

### `avoid_web_libraries_in_flutter: true`
**What it checks:** Flags importing `dart:html`, `dart:js`, etc. inside Flutter code meant to run on multiple platforms (not just web).
**Why:** These libraries are unavailable on mobile/desktop and break non-web builds.

✅ Correct: use `package:flutter/foundation.dart`'s `kIsWeb` + conditional imports, or a platform-agnostic package.

❌ Incorrect: `import 'dart:html' as html;` directly inside shared Flutter widget code.

### `avoid_unnecessary_containers: true`
**What it checks:** Flags a `Container` used with no properties at all (just wrapping a single child), which is redundant.

✅ Correct: `const Text('Hello');`

❌ Incorrect: `Container(child: const Text('Hello'));` (no padding/color/decoration — the `Container` adds nothing)

### `avoid_print: true`
**What it checks:** Flags calls to `print()`.
**Why:** `print` is not suitable for production logging (no log levels, filtering, or release-mode stripping); prefer a logging package.

✅ Correct: `log.info('User signed in');`

❌ Incorrect: `print('User signed in');`

### `prefer_final_locals: true`
**What it checks:** Requires local variables that are never reassigned to be declared `final` instead of `var`.

✅ Correct: `final total = price * quantity;`

❌ Incorrect: `var total = price * quantity; // never reassigned afterwards`

### `cascade_invocations: true`
**What it checks:** Suggests the cascade operator (`..`) when multiple consecutive statements operate on the same target.

✅ Correct:
```dart
final buffer = StringBuffer()
  ..write('Hello')
  ..write(' World');
```

❌ Incorrect:
```dart
final buffer = StringBuffer();
buffer.write('Hello');
buffer.write(' World');
```

### `always_put_control_body_on_new_line: true`
**What it checks:** Requires the body of `if`/`for`/`while`/etc. to start on a new line, not on the same line as the control keyword (even without braces).

✅ Correct:
```dart
if (isValid)
  doSomething();
```

❌ Incorrect:
```dart
if (isValid) doSomething();
```

> Note: this rule works together with `curly_braces_in_flow_control_structures` above — in practice, since braces are required, bodies naturally end up on their own line inside `{ }`.

---

## 7. Summary for AI-assisted code generation

When Copilot/Claude generates or edits Dart/Flutter code in this repository, it must, by default:

1. Use `'single quotes'`, `const` wherever possible, and `final` for locals that aren't reassigned.
2. Keep methods short (≤ ~250 LOC, cyclomatic complexity ≤ 20, nesting ≤ 5 levels) and split large widgets/classes into smaller ones instead of writing widget-returning helper methods.
3. Never leave `addListener`/`StreamSubscription`/`Sink` without a matching cleanup in `dispose()`.
4. Avoid `dynamic` and `!` (null-assertion); prefer explicit types and null-safe patterns.
5. Follow the configured `member-ordering` (dispose → lifecycle methods → build → constructor; private fields → public fields → constructors).
6. Use named constants instead of magic numbers, and named data classes instead of long parameter lists (> 4 params).
7. Prefer `ListView.builder` for scrollable collections, `SizedBox` for pure spacing, and `Spacer` instead of an empty `Expanded`.
8. Never use `print()` — use a logging abstraction.
9. Always check `context.mounted` after an `await` before using a `BuildContext`.
10. Remember that `parameter_assignments`, `missing_return`, and `missing_required_param` are build-breaking **errors** in this project, not just warnings.
