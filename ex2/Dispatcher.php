<?php

require __DIR__ . '/../vendor/autoload.php';

use Sinergi\Gearman\Dispatcher;
use Sinergi\Gearman\Config;

$config = (new Config())
    ->addServer('127.0.0.1', 4730)
    ->setUser('gearman');

$dispatcher = new Dispatcher($config);
$dispatcher->execute('JobExample', ['data' => 'value']);