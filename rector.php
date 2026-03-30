<?php

declare(strict_types=1);

/*
 * This file is part of your package.
 */

use Rector\Config\RectorConfig;
use Rector\TypeDeclaration\Rector\StmtsAwareInterface\SafeDeclareStrictTypesRector;

return RectorConfig::configure()
    ->withPaths([
        __DIR__ . '/src',
        __DIR__ . '/tests',
    ])
    ->withPhpSets()
    ->withPreparedSets(
        deadCode: true,
        codeQuality: true,
        earlyReturn: true,
        naming: true,
        privatization: true,
        typeDeclarations: true,
    )
    ->withRules([
        SafeDeclareStrictTypesRector::class,
    ]);
