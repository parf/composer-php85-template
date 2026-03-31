# PHP 8.5 Composer Package Template

Starter template for PHP 8.5 packages that use standalone shared CLI tooling from `php-tools`.

## How To Use

```bash
composer create-project parf/composer-php85-template your-project-name
cd your-project-name
```

Install shared `php-tools` with:

- https://github.com/parf/composer-php85-template/blob/main/docs/setup-tools.howto

Then create the local `tools` symlink, rename the sample package bits, and run `composer check`.

## Tools Configuration

The suite commands read [config/tools.conf](config/tools.conf).

Use this file to choose which tools are active in your project. If you do not want to use a tool, set its flag to `0`. That lets you keep the shared command surface while tailoring the template to the actual stack you want to keep.

Enabled tools control what these commands run:

- `composer check` for full validation
- `composer dry` for non-mutating static validation
- `composer test`
- `composer fix`
- `composer doc`

## Why This Template Uses `php-tools`

This template keeps CLI tools in a shared `php-tools` install instead of `require-dev`, so project dependencies stay small and the same toolchain can be reused across projects.

Included tools: PHP lint, [Mago](https://mago.carthage.software/guide/installation), [Psalm](https://psalm.dev/docs/annotating_code/supported_annotations/), [PHPStan](https://phpstan.org/writing-php-code/phpdocs-basics), [Rector](https://github.com/rectorphp/rector/blob/main/docs/rector_rules_overview.md), [phpDocumentor](https://docs.phpdoc.org/3.0/guide/guides/running-phpdocumentor.html#quickstart), [php-cs-fixer](https://mlocati.github.io/php-cs-fixer-configurator/), [spartan-test](https://github.com/parf/spartan-test), [Pest](https://pestphp.com/), [PsySH](https://psysh.org/).

## Main Commands

> `composer check`<br>
    run the full validation pass: enabled dry-mode tools, then enabled tests

> `composer dry`<br>
    run enabled tools in non-mutating mode without running tests

> `composer test`<br>
    run enabled test runners

> `composer fix`<br>
    run enabled tools in mutating mode

> `composer doc`<br>
    generate docs when documentation tooling is enabled

Other commands are listed in [COMMANDS.md](docs/COMMANDS.md).

## Typical Workflow

1. run `composer dry` to inspect non-mutating tool results
2. run `composer test` to run enabled tests
3. run `composer fix` if you want to apply automated changes
4. run `composer check` before commit or push

## GitHub Starter Files

The template includes optional GitHub repository scaffolding:

- Actions workflows for linting and tests
- Dependabot configuration
- issue templates for bug reports and questions

These are adapted for the standalone `php-tools` workflow and do not require Docker.

## GitHub CI

GitHub Actions workflows are provided in:

- `.github/workflows/lint.yml`
- `.github/workflows/tests.yml`

They run automatically on `push` and `pull_request`.

Workflow coverage:

- `Lint`: installs `php-tools`, then runs `composer dry`
- `Tests`: installs `php-tools`, installs `GNU parallel`, then runs `composer test`

Local equivalents:

- run `composer check` for the main validation flow
- run `composer dry` for the non-mutating lint/analyzer pass
- run `composer test` for the bundled Spartan + Pest test flow
- the `Lint` workflow is equivalent to `composer dry`

If you do not want GitHub CI in your derived project, remove the `.github/workflows/` files.

## Project Layout

- `src/TemplatePackage/` contains a sample `HelloWorlds` class
- `tests/Test.stest` is the starter Spartan test
- `tests/Pest.php` and `tests/Pest/HelloWorldsTest.php` are the starter Pest tests
- `config/tools.conf` enables or disables tools used by the suite commands
- `scripts/test-suite.sh` runs the enabled test runners for `composer test`
- `tests/fixtures-src/` is reserved for test-only sample source files if the package grows

If your test suite grows, group tests by topic under `tests/` instead of keeping everything in one file.

## Analyzer Notes

See [ANALYZER-HOWTO.md](docs/ANALYZER-HOWTO.md) for quick Psalm and PHPStan notes.
