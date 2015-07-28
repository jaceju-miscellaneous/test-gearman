<?php
$id = microtime(true);
$worker = new GearmanWorker();
$worker->addServer(); // 預設為 localhost
$worker->addFunction('sendEmail', 'doSendEmail');
$worker->addFunction('resizeImage', 'doResizeImage');
while($worker->work()) {
    if ($worker->returnCode() != GEARMAN_SUCCESS) {
        break;
    }
    sleep(1); // 無限迴圈，並讓 CPU 休息一下
}
function doSendEmail($job)
{
    global $id;
    $data = unserialize($job->workload());
    print_r($data);
    sleep(10); // 模擬處理時間
    echo "$id: Email sending is done really.\n\n";
}
function doResizeImage($job)
{
    global $id;
    $data = unserialize($job->workload());
    print_r($data);
    sleep(10); // 模擬處理時間
    echo "$id: Image resizing is really done.\n\n";
}
