<?php

// comment out the following two lines when deployed to production
// Comentar estas 2 lineas cuando Empiece la produccion
defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'dev');//Define Variable estatica Modo Desarrollo o Prueba

require(__DIR__ . '/../vendor/autoload.php');//Carga de Archivos de Vendor
require(__DIR__ . '/../vendor/yiisoft/yii2/Yii.php');

$config = require(__DIR__ . '/../config/web.php');

(new yii\web\Application($config))->run(); 