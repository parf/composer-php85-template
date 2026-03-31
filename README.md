# PHP 8.5 Composer Package Template

Starter template for PHP 8.5 packages that use standalone shared CLI tooling from `php-tools`.

## Summary

This repository gives you a modern PHP 8.5 package template with a shared `php-tools` toolchain, configurable suite commands, sample Spartan and Pest tests, static analysis, refactoring, formatting, documentation generation, and optional GitHub CI scaffolding ✨

You can turn individual tools on or off in [config/tools.conf](config/tools.conf), so each project can keep the same friendly workflow while enabling only the parts it actually wants to use ⚙️

## How To Use

```bash
composer create-project parf/composer-php85-template your-project-name
cd your-project-name
```

First, install shared `php-tools` with:

- https://github.com/parf/composer-php85-template/blob/main/docs/setup-tools.howto

Then create the local `tools` symlink, rename the sample package bits, and run `composer check` to make sure everything is wired correctly ✅

## Commands And Workflow

1. run `composer dry` to inspect non-mutating tool results
2. run `composer test` to run enabled tests
3. run `composer fix` if you want to apply automated changes
4. run `composer check` for the full validation pass before commit or push
5. run `composer doc` when you want to generate documentation

Helper commands:

- `./check-commit` runs `composer check`, then creates a commit from already staged files
- `./check-push` runs `composer check`, then pushes the current branch
- `./psysh` starts the interactive PHP shell

If a required tool fails during `composer check`, then `./check-commit` and `./check-push` stop immediately and no commit or push is performed.

Need the full command list? See [COMMANDS.md](docs/COMMANDS.md) 📘

## Tools Configuration

The suite commands read [config/tools.conf](config/tools.conf).

Use this file to choose which tools are active in your project. If you do not want to use a tool, set its flag to `0`. That way you keep the same shared command surface while tailoring the template to the stack you actually want ⚙️

## Why This Template Uses `php-tools`

This template keeps CLI tools in a shared `php-tools` install instead of `require-dev`, so project dependencies stay small and the same toolchain can be reused across projects 🔧

Included tools: PHP lint, [Mago](https://mago.carthage.software/guide/installation), [Psalm](https://psalm.dev/docs/annotating_code/supported_annotations/), [PHPStan](https://phpstan.org/writing-php-code/phpdocs-basics), [Rector](https://github.com/rectorphp/rector/blob/main/docs/rector_rules_overview.md), [phpDocumentor](https://docs.phpdoc.org/3.0/guide/guides/running-phpdocumentor.html#quickstart), [php-cs-fixer](https://mlocati.github.io/php-cs-fixer-configurator/), [spartan-test](https://github.com/parf/spartan-test), [Pest](https://pestphp.com/), [PsySH](https://psysh.org/).

## GitHub Starter Files

The template includes optional GitHub repository scaffolding:

- Actions workflows for linting and tests
- Dependabot configuration
- issue templates for bug reports and questions

These files are adapted for the standalone `php-tools` workflow and do not require Docker 🐳

## GitHub CI

GitHub Actions workflows are provided in:

- `.github/workflows/lint.yml`
- `.github/workflows/tests.yml`

They run automatically on `push` and `pull_request`.

Workflow coverage:

- `Lint`: installs `php-tools`, then runs `composer dry`
- `Tests`: installs `php-tools`, installs `GNU parallel`, then runs `composer test`

Local equivalents:

- `Lint` is equivalent to `composer dry`
- `Tests` is equivalent to `composer test`

If you do not want GitHub CI in your derived project, just remove the `.github/workflows/` files.

## Project Layout

- `src/TemplatePackage/` contains a sample `HelloWorlds` class
- `tests/Test.stest` is the starter Spartan test
- `tests/Pest.php` and `tests/Pest/HelloWorldsTest.php` are the starter Pest tests
- `scripts/test-suite.sh` runs the enabled test runners for `composer test`
- `tests/fixtures-src/` is reserved for test-only sample source files if the package grows

If your test suite grows, group tests by topic under `tests/` instead of keeping everything in one file. That keeps the starter layout simple while leaving room to grow 🌱

## Analyzer Notes

See [ANALYZER-HOWTO.md](docs/ANALYZER-HOWTO.md) for quick Psalm and PHPStan notes.
