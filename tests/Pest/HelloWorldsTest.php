<?php

declare(strict_types=1);

/*
 * This file is part of your package.
 */

use TemplatePackage\HelloWorlds;

test('hello uses english by default', function (): void {
    $helloWorlds = new HelloWorlds();

    expect($helloWorlds->hello('World'))->toBe('Hello, World!');
});

test('hello supports known languages', function (): void {
    $helloWorlds = new HelloWorlds();

    expect($helloWorlds->hello('Mondo', 'it'))->toBe('Ciao, Mondo!');
});

test('hello falls back to english for unknown languages', function (): void {
    $helloWorlds = new HelloWorlds();

    expect($helloWorlds->hello('World', 'xx'))->toBe('Hello, World!');
});

test('helloMany returns one greeting per name', function (): void {
    $helloWorlds = new HelloWorlds();

    expect($helloWorlds->helloMany(['Mercury', 'Venus'], 'fr'))->toBe(['Bonjour, Mercury!', 'Bonjour, Venus!']);
});

test('summary joins greetings with a stable separator', function (): void {
    $helloWorlds = new HelloWorlds();

    expect($helloWorlds->summary(['Earth', 'Mars']))->toBe('Hello, Earth! | Hello, Mars!');
});
