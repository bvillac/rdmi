<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\PacienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Pacientes';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="paciente-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Nuevo Paciente', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

</div>


<div>
    <?=
    GridView::widget([
        'id' => 'TbG_PACIENTE',
        'dataProvider' => $model,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
//            [
//                'attribute' => 'Ids',
//                'header' => Yii::t("formulario", "ID"),
//                'value' => 'Ids',
//            ],
            [
                'header' => Yii::t("formulario", "DNI"),
                //'options' => ['width' => '200'],
                'value' => function ($model) {
                    return ($model['DNI'] != NULL) ? $model['DNI'] : '';
                },
            ],
            [
                'attribute' => 'Nombres',
                'header' => Yii::t("formulario", "Name"),
                //'options' => ['width' => '200'],
                'value' => 'Nombres',
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
                    'view' => function ($url, $model) {                       
                        return Html::a('<span class="glyphicon glyphicon-list-alt"></span>', Url::to(['medico/view', 'ids' => base64_encode($model['Ids'])]), ["data-toggle" => "tooltip", "title" => "Ver Ficha"]);
                    },
                    'update' => function ($url, $model) {
                            return Html::a('<span class="glyphicon glyphicon-pencil"></span>', Url::to(['medico/update', 'ids' => base64_encode($model['Ids'])]), ["data-toggle" => "tooltip", "title" => "Editar"]);
                    },
                    'delete' => function ($url, $model) {
                        return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:eliminarDatos(\'' . base64_encode($model['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Eliminar"]);
                    },
                        ],
                    ],
               
        ],
    ])
    ?>
</div>
<script>
    var AccionTipo='Index';
</script>

