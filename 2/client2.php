<?php

$client = new GearmanClient();
$client->addServer(); // 預設為 localhost
$result = $client->doBackground('job-server-01-default_job', 'php worker2.php 123 456 789');
