# Commands

Detailed command reference:

- `composer lint` checks PHP syntax in `src/`.
- `composer check` runs the full validation pass with compact success output.
- `composer dry` runs enabled non-mutating checks.
- `composer test` runs the enabled test runners.
- `composer fix` runs enabled mutating tools.
- `composer doc` generates docs when documentation tooling is enabled.
- `composer stest` runs Spartan Test across `tests/`.
- `composer stest-q` runs Spartan Test in quiet mode and shows failures only.
- `composer pest` runs Pest through the local wrapper. Pest is the PHPUnit-style test runner in this template.
- `composer pest-q` runs Pest in compact mode with the same local wrapper.
- `composer stan` runs PHPStan on `src/` with the project config. PHPStan catches type mistakes and other static issues without executing the code.
- `composer stan-q` runs PHPStan in quiet mode.
- `composer stan2` runs PHPStan at level 2.
- `composer stan3` runs PHPStan at level 3.
- `composer stan4` runs PHPStan at level 4.
- `composer stan5` runs PHPStan at level 5.
- `composer stan6` runs PHPStan at level 6.
- `composer psalm` runs Psalm. It adds stricter type and data-flow analysis on top of PHPStan.
- `composer psalm-dry` previews supported Psalm fixes.
- `composer psalm-fix` applies supported Psalm fixes.
- `composer mago-lint` runs Mago linting on `src/`.
- `composer mago-analyze` runs Mago analysis on `src/`. Mago is the modern all-in-one lint/analyze/format tool in this template.
- `composer mago-format-dry` previews Mago formatting changes in `src/`.
- `composer mago-format-check` checks whether `src/` is already formatted for Mago.
- `composer mago-format` applies Mago formatting to `src/`.
- `composer cs-dry` runs `php-cs-fixer` in dry mode. This is the template's opinionated coding-style layer.
- `composer cs-fix` applies `php-cs-fixer` changes.
- `composer rector-dry` previews Rector changes. Rector automates refactors, modernization, and structural cleanup.
- `composer rector` applies Rector changes using the same configuration.
- `composer phpdoc` runs phpDocumentor and writes output to `doc/`. Use it for generated API-style documentation.
- `./check` runs the full validation flow and prints one line per successful tool.
- `./check-commit [commit-message]`
  - runs `./check`
  - if check succeeds, shows the files that would be added/committed
  - asks for a commit message if needed
  - if the prompt is left empty, exits with `1`, does not create a commit, and does not add new files to git
  - stages all changes, then creates the **commit**
- `./check-push [commit-message] [branch]`
  - runs `./check-commit`
  - **pushes** after a **successful** check and commit
  - optional second argument: target branch
- `./psysh` starts the interactive PHP shell.

Notes:

- `composer dry` runs independent read-only tools in **parallel** where possible.
- `composer stest` uses `stest-all`, which executes `.stest` files in parallel.
- `config/tools.conf` controls which tools are active for the suite commands.
