<?php

declare(strict_types=1);

/*
 * This file is part of your package.
 */

use Pest\Kernel;
use Pest\Panic;
use Pest\TestCaseFilters\GitDirtyTestCaseFilter;
use Pest\TestCaseMethodFilters\AssigneeTestCaseFilter;
use Pest\TestCaseMethodFilters\IssueTestCaseFilter;
use Pest\TestCaseMethodFilters\NotesTestCaseFilter;
use Pest\TestCaseMethodFilters\PrTestCaseFilter;
use Pest\TestCaseMethodFilters\TodoTestCaseFilter;
use Pest\TestSuite;
use Symfony\Component\Console\Input\ArgvInput;
use Symfony\Component\Console\Output\ConsoleOutput;

$projectRoot = dirname(__DIR__);
$projectAutoload = $projectRoot . '/vendor/autoload.php';

if (!file_exists($projectAutoload)) {
    fwrite(STDERR, "Missing vendor/autoload.php. Run composer install first.\n");

    exit(1);
}

$sharedPestBinary = trim((string) shell_exec('command -v pest 2>/dev/null'));

if ($sharedPestBinary === '') {
    fwrite(STDERR, "Missing shared Pest binary on PATH.\n");
    fwrite(STDERR, "Install shared php-tools first:\n");
    fwrite(STDERR, "https://github.com/parf/composer-php85-template/blob/main/docs/setup-tools.howto\n");

    exit(1);
}

$sharedPestBinary = (string) realpath($sharedPestBinary);

$sharedPestAutoload = dirname($sharedPestBinary, 2) . '/autoload.php';

if (!file_exists($sharedPestAutoload)) {
    fwrite(STDERR, "Missing shared Pest autoload file.\n");

    exit(1);
}

require_once $projectAutoload;

require_once $sharedPestAutoload;

(static function (string $projectRoot): void {
    $_SERVER['COLLISION_PRINTER'] = 'DefaultPrinter';

    $arguments = $originalArguments = $_SERVER['argv'];

    $dirty = false;
    $todo = false;
    $notes = false;

    foreach ($arguments as $key => $value) {
        if ($value === '--compact') {
            $_SERVER['COLLISION_PRINTER_COMPACT'] = 'true';
            unset($arguments[$key]);
        }

        if ($value === '--profile') {
            $_SERVER['COLLISION_PRINTER_PROFILE'] = 'true';
            unset($arguments[$key]);
        }

        if (str_contains($value, '--test-directory=')) {
            unset($arguments[$key]);
        } elseif ($value === '--test-directory') {
            unset($arguments[$key]);

            if (isset($arguments[$key + 1])) {
                unset($arguments[$key + 1]);
            }
        }

        if ($value === '--dirty') {
            $dirty = true;
            unset($arguments[$key]);
        }

        if (in_array($value, ['--todo', '--todos'], true)) {
            $todo = true;
            unset($arguments[$key]);
        }

        if ($value === '--notes') {
            $notes = true;
            unset($arguments[$key]);
        }

        foreach (['--assignee', '--issue', '--ticket', '--pr', '--pull-request'] as $option) {
            if (str_contains($value, $option . '=')) {
                unset($arguments[$key]);
            } elseif ($value === $option) {
                unset($arguments[$key]);

                if (isset($arguments[$key + 1])) {
                    unset($arguments[$key + 1]);
                }
            }
        }

        if (str_contains($value, '--teamcity')) {
            unset($arguments[$key]);
            $arguments[] = '--no-output';
            unset($_SERVER['COLLISION_PRINTER']);
        }
    }

    $input = new ArgvInput();
    $testSuite = TestSuite::getInstance($projectRoot, $input->getParameterOption('--test-directory', 'tests'));

    if ($dirty) {
        $testSuite->tests->addTestCaseFilter(new GitDirtyTestCaseFilter($projectRoot));
    }

    if ($todo) {
        $testSuite->tests->addTestCaseMethodFilter(new TodoTestCaseFilter());
    }

    if ($notes) {
        $testSuite->tests->addTestCaseMethodFilter(new NotesTestCaseFilter());
    }

    if ($assignee = $input->getParameterOption('--assignee')) {
        $testSuite->tests->addTestCaseMethodFilter(new AssigneeTestCaseFilter((string) $assignee));
    }

    if ($issue = $input->getParameterOption('--issue')) {
        $testSuite->tests->addTestCaseMethodFilter(new IssueTestCaseFilter((int) $issue));
    }

    if ($issue = $input->getParameterOption('--ticket')) {
        $testSuite->tests->addTestCaseMethodFilter(new IssueTestCaseFilter((int) $issue));
    }

    if ($pr = $input->getParameterOption('--pr')) {
        $testSuite->tests->addTestCaseMethodFilter(new PrTestCaseFilter((int) $pr));
    }

    if ($pr = $input->getParameterOption('--pull-request')) {
        $testSuite->tests->addTestCaseMethodFilter(new PrTestCaseFilter((int) $pr));
    }

    $isDecorated = $input->getParameterOption('--colors', 'always') !== 'never';
    $output = new ConsoleOutput(ConsoleOutput::VERBOSITY_NORMAL, $isDecorated);

    try {
        $kernel = Kernel::boot($testSuite, $input, $output);
        $result = $kernel->handle($originalArguments, $arguments);
        $kernel->terminate();
    } catch (Error|Throwable $e) {
        Panic::with($e);
    }

    exit($result);
})($projectRoot);
