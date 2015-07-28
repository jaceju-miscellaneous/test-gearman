<?php

use Sinergi\Gearman\JobInterface;

class JobExample implements JobInterface
{
    public function getName()
    {
        return 'JobExample';
    }

    public function execute(GearmanJob $job = null)
    {
        var_dump($job);
    }
}