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
