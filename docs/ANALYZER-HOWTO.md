# Analyzer How-To

## Psalm

Docs:

- https://psalm.dev/docs/
- https://psalm.dev/docs/manipulating_code/fixing/

Common suppressions:

- `@psalm-suppress InvalidReturnStatement`
- `@psalm-suppress all`

Use `composer psalm-dry` before `composer psalm-fix`.

## PHPStan

Docs:

- https://phpstan.org/blog/guides
- https://phpstan.org/user-guide/ignoring-errors

Common line suppressions:

- `/** @phpstan-ignore-line */`
- `/** @phpstan-ignore-next-line */`

## Rector

Default template setup:

- PHP upgrade sets up to the version supported by the shared Rector install
- default sets:
  - `PHP_82`
  - `CODE_QUALITY`
  - `TYPE_DECLARATION`
  - `DEAD_CODE`
  - `PRIVATIZATION`
  - `NAMING`
  - `EARLY_RETURN`
- level set:
  - `UP_TO_PHP_82`

Use:

- `composer rector-dry` to preview changes
- `composer rector` to apply changes
