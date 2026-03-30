<?php

declare(strict_types=1);

/*
 * This file is part of your package.
 */

namespace TemplatePackage;

final class HelloWorlds
{
    /**
     * @var array<string, string>
     */
    private const array HELLOS = [
        'en' => 'Hello',
        'es' => 'Hola',
        'fr' => 'Bonjour',
        'it' => 'Ciao',
    ];

    public function hello(string $name, string $language = 'en'): string
    {
        return $this->prefixFor($language) . ', ' . $name . '!';
    }

    /**
     * @param list<string> $names
     *
     * @return list<string>
     */
    public function helloMany(array $names, string $language = 'en'): array
    {
        $prefix = $this->prefixFor($language);

        return array_map(static fn(string $name): string => $prefix . ', ' . $name . '!', $names);
    }

    public function excitedHello(string $name, string $language = 'en'): string
    {
        return strtoupper($this->hello($name, $language));
    }

    /**
     * @param list<string> $names
     */
    public function summary(array $names, string $language = 'en'): string
    {
        $greetings = $this->helloMany($names, $language);

        return implode(' | ', $greetings);
    }

    private function prefixFor(string $language): string
    {
        return self::HELLOS[$language] ?? self::HELLOS['en'];
    }
}
