<?php

$client = new GearmanClient();
$client->addServer(); // 預設為 localhost
$emailData = array(
    'name' => 'web',
    'email' => 'member@example.com',
);
$imageData = array(
    'image' => '/var/www/pub/image/test.png',
);
$client->doBackground('sendEmail', serialize($emailData));
echo "Email sending is done.\n";
$client->doBackground('resizeImage', serialize($imageData));
echo "Image resizing is done.\n";
