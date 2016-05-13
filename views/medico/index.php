<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\MedicoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Medicos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="medico-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Nuevo Medico', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

</div>

<div>
    <?=
    GridView::widget([
        'id' => 'TbG_MEDICO',
        //'showExport' => true,
        //'fnExportEXCEL' => "exportExcel",
        //'fnExportPDF' => "exportPdf",
        'dataProvider' => $dataProvider,
        //'pajax' => false,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
            [
                'attribute' => 'Ids',
                'header' => Yii::t("formulario", "ID"),
                'value' => 'Ids',
            ],
            [
                'attribute' => 'Nombres',
                'header' => Yii::t("formulario", "Name"),
                //'options' => ['width' => '200'],
                'value' => 'Nombres',
            ],
            [
                'header' => Yii::t("formulario", "Registro"),
                //'options' => ['width' => '200'],
                'value' => 'Registro',
            ],
            [
                'header' => Yii::t("formulario", "Empresa"),
                //'options' => ['width' => '200'],
                'value' => 'Empresa',
            ],
            [
                'header' => Yii::t("formulario", "Estado"),
                'value' => function ($model) {
                    return ($model['Estado'] == 1) ? 'Activo' : 'Inactivo';
                },
            ],
                        
            [
                'class' => 'yii\grid\ActionColumn',
                //'header' => Yii::t("formulario", "Acciones"),
                //'headerOptions' => ['width' => '30'],
                'template' => '{view} {update} {delete} ', //
                'buttons' => [
                    'view' => function ($url, $dataProvider) {//glyphicon-download-alt
                        return Html::a('<span class="glyphicon glyphicon-list-alt"></span>', Url::to(['mceformulario/solicitudpdf', 'ids' => base64_encode($dataProvider['Ids']), 'pdf' => 1]), [ "data-toggle" => "tooltip", "title" => "Ver Ficha"]);
                    },
                    'update' => function ($url, $dataProvider) {
                        if ($model['Estado'] < '3') {
                            return Html::a('<span class="glyphicon glyphicon-pencil"></span>', Url::to(['mceformulario/view', 'ids' => base64_encode($dataProvider['Ids'])]), ["data-toggle" => "tooltip", "title" => "Editar"]);
                        }
                    },
                    'delete' => function ($url, $dataProvider) {
                        return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:eliminarDatos(\'' . base64_encode($dataProvider['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Eliminar"]);
                    },
                        ],
                    ],
               
        ],
    ])
    ?>
</div>

