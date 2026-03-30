# PHP 8.5 Composer Package Template

Starter template for PHP 8.5 packages that use standalone shared CLI tooling from `php-tools`.

## How To Use

```bash
composer create-project parf/composer-php85-template your-project-name
cd your-project-name
```

Then:

1. install `php-tools`
2. create the local `tools` symlink
3. edit `composer.json`
4. rename the sample namespace and source tree
5. run `composer install`

See [setup-tools.howto](setup-tools.howto) for the shared tools bootstrap.

## Why This Template Uses `php-tools`

This template intentionally keeps CLI tools separate from project dependencies.

That means:

- project Composer dependencies stay minimal
- tool upgrades are managed from one shared `php-tools` checkout
- the same analyzer and refactoring binaries can be reused across multiple projects

## Included Tools

- PHP lint
- [Mago](https://mago.carthage.software/guide/installation)
- [Psalm](https://psalm.dev/docs/annotating_code/supported_annotations/)
- [PHPStan](https://phpstan.org/writing-php-code/phpdocs-basics)
- [Rector](https://github.com/rectorphp/rector/blob/main/docs/rector_rules_overview.md)
- [phpDocumentor](https://docs.phpdoc.org/3.0/guide/guides/running-phpdocumentor.html#quickstart)
- [php-cs-fixer](https://mlocati.github.io/php-cs-fixer-configurator/)
- [spartan-test](https://github.com/parf/spartan-test)
- [Pest](https://pestphp.com/)
- [PsySH](https://psysh.org/)

## Main Commands

> `composer test`<br>
    run `spartan-test`

> `composer pest`<br>
    run Pest through the shared `php-tools` install

> `composer psalm`<br>
    run Psalm

> `composer stan`<br>
    run PHPStan

> `composer mago-lint` / `composer mago-analyze`<br>
    run Mago linting and static analysis with PHP 8.5 selected

> `composer mago-format-dry` / `composer mago-format`<br>
    review or apply Mago formatting

> `composer lint`<br>
    run PHP syntax checks

> `composer psalm-dry` / `composer psalm-fix`<br>
    review or apply selected Psalm fixes

> `composer cs-dry` / `composer cs-fix`<br>
    review or apply formatting changes

> `composer rector-dry` / `composer rector`<br>
    review or apply Rector changes

> `composer doc`<br>
    generate docs in `doc/`

> `./check`<br>
    run lint, formatting check, tests, Psalm, and PHPStan without mutating files

> `./check-commit`<br>
    run checks, then commit already staged files

> `./check-push`<br>
    run checks, then push current branch with tags

> `./psysh`<br>
    start the interactive PHP shell

## Project Layout

- `src/TemplatePackage/` contains a sample `HelloWorlds` class
- `tests/Test.stest` is the starter Spartan test
- `tests/Pest.php` and `tests/Pest/HelloWorldsTest.php` are the starter Pest tests
- `tests/fixtures-src/` is reserved for test-only sample source files if the package grows

If your test suite grows, group tests by topic under `tests/` instead of keeping everything in one file.

## Analyzer Notes

See [ANALYZER-HOWTO.md](ANALYZER-HOWTO.md) for quick Psalm and PHPStan notes.
