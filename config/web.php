<?php
Yii::setAlias('@modules', dirname(__DIR__) . '/modules');
Yii::setAlias('@themes', dirname(__DIR__) . '/themes');
Yii::setAlias('@widgets', dirname(__DIR__) . '/widgets');
Yii::setAlias('@views', dirname(__DIR__) . '/views');
Yii::setAlias('@assets', dirname(__DIR__) . '/assets');
$params = require(__DIR__ . '/params.php');

$config = [
    'id' => 'mce',
    'name' => 'Ministerio del Comercio Exterior',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'language' => 'es',
    'sourceLanguage' => 'en',
    'modules' => [],
    'components' => [
        'i18n' => [
            'translations' => [
                '*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'fileMap' => [],
                ],
            ],
        ],
        'view' => [
             'theme' => [
                 'class' => '\app\components\CTheme',
                 'pathMap' => [
                    '@app/views' => '@app/themes/adminLTE',
                 ],
                 'baseUrl' => '@web/themes/adminLTE',
                 'themeName' => 'adminLTE',
            ],
        ],
        'urlManager' => [
            'class' => 'yii\web\UrlManager',
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'enableStrictParsing' => false,
            'baseUrl' => '/mce',
            'rules' => [
                // REST patterns
                'GET api/list/<modelo:\w+>/format' => 'api/list',
                'GET api/view/<modelo:\w+>/<id:\d+>/format' => 'api/view',
                'PUT api/update/<modelo:\w+>/<id:\d+>/format' => 'api/update',
                'DELETE api/delete/<modelo:\w+>/<id:\d+>/format' => 'api/delete',
                'POST api/create/<modelo:\w+>/format' => 'api/create',
                'POST api/request/<modelo:\w+>/<metodo:\w+>/<format:\w+>' => 'api/request',
                [
                    'class' => 'yii\rest\UrlRule',
                    'controller' => 'api'
                ],
            ],
        ],
        'request' => [
            'baseUrl' => '/mce',
            'cookieValidationKey' => 'mce2703401',
            'parsers' => [
                'application/json' => 'yii\web\JsonParser',
            ],
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'identityClass' => 'app\models\Usuario',
            'enableAutoLogin' => true,
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => require(__DIR__ . '/mailer.php'), 
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => require(__DIR__ . '/db.php'),
        'session' => [
            'class' => 'yii\web\DbSession',
            'timeout' => 3600, // en segundos
        ],
    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    //$config['bootstrap'][] = 'debug';
    //$config['modules']['debug'] = 'yii\debug\Module';
    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = 'yii\gii\Module'; // http://hostname/index.php?r=gii
}
return $config;
