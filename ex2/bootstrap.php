<?php

require __DIR__ . '/../vendor/autoload.php';

use Sinergi\Gearman\BootstrapInterface;
use Sinergi\Gearman\Application;

class MyBootstrap implements BootstrapInterface
{
    public function run(Application $application)
    {
        $application->add(new JobExample());
    }
}