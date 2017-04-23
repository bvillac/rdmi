<?php
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//['Ids','Tipo','Titulo','File','Ruta','Fecha']
use yii\helpers\Html;
use yii\helpers\Url;
use app\widgets\PbGridView\PbGridView;
?>
<div class="row">
    <div class="col-md-12">
        <?=
        PbGridView::widget([
            'id' => 'TbG_DATOS',
            'dataProvider' => $modelfile,
            //'summary' => false,
            'columns' => [
                ['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
                // format one
                //[
                //'attribute' => 'Ids',
                //'label' => 'Idst',
                //],
                // format two
                [
                    'header' => Yii::t("formulario", "Titulo"),
                    //'options' => ['width' => '200'],
                    'value' => 'Titulo',
                ],
                [
                    'header' => Yii::t("formulario", "Fecha"),
                    'format' => ['date', 'php:' . Yii::$app->params["dateTimeByDefault"]],
                    'value' => 'Fecha',
                //'options' => ['width' => '180'],
                ],
                [
                    'class' => 'yii\grid\ActionColumn',
                    //'header' => 'Action',
                    'headerOptions' => ['width' => '50'],
                    'template' => '{view} {delete}', //
                    'buttons' => [
                                'view' => function ($url, $modelfile) {
                                    //return Html::a('<span class="glyphicon glyphicon-download-alt"></span>', Url::to(['mceformulario/solicitudpdf', 'ids' => base64_encode($modelfile['Ids']), 'pdf' => 1]), ["target" => "_blank", "data-toggle" => "tooltip", "title" => "Descargar Archivo", "data-pjax" => 0]);
                                    //return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:downloadFile(\'' . base64_encode($modelfile['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Eliminar Archivo"]);
                                    //return  Html::a('Action', Url::to(['mceformulariotemp/solicitudpdf','ids' => 1],['class' => 'btn btn-default',"target" => "_blank"]));
                                    //return Html::a('<span class="glyphicon glyphicon-download-alt"></span>', Url::to(['medico/downloadfile', 'ids' => base64_encode($modelfile['Ids'])]), ["target" => "_blank", "data-toggle" => "tooltip", "title" => "Descargar Archivo", "data-pjax" => 0]);
                                    return Html::a('<span class="glyphicon glyphicon-download-alt"></span>', Url::to(['medico/downloadfile', 'ids' => base64_encode($modelfile['Ids'])]), ["data-toggle" => "tooltip", "title" => "Descargar Archivo", "data-pjax" => 0]);
                                },
                                'delete' => function ($url, $modelfile) {
                                    //return Html::a('<span class="glyphicon glyphicon-pencil"></span>', Url::to(['mceformulariotemp/update', 'ids' => base64_encode($model['Ids'])]));
                                    //if ($model['Estado'] < '3') {
                                        return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:deleteFile(\'' . base64_encode($modelfile['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Eliminar Archivo"]);
                                        //return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:deleteFile(\'' . $modelfile['Ids'] . '\');', "data-toggle" => "tooltip", "title" => "Eliminar Archivo"]);
                                    //}
                                },
                        ],
                ],
            ],
        ])
        ?>

    </div>



</div>

