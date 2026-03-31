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

- `withPhpSets()` enabled, so Rector follows the PHP version declared by the project
- prepared sets:
  - `deadCode`
  - `codeQuality`
  - `earlyReturn`
  - `naming`
  - `privatization`
  - `typeDeclarations`
- explicit rule:
  - `SafeDeclareStrictTypesRector`

Use:

- `composer rector-dry` to preview changes
- `composer rector` to apply changes
