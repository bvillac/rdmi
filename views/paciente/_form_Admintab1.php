<?php

use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
//use yii\grid\GridView;
use app\widgets\PbGridView\PbGridView;
use yii\data\ArrayDataProvider;
?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Citas Pacientes") ?></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_especialidadCita" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_especialidadCita", 0, ['0' => Yii::t('formulario', 'Todos')] + ArrayHelper::map($EspPac, 'IdsEsp', 'Especialidad'), ["class" => "form-control", "id" => "cmb_especialidadCita"]
            )
            ?>
        </div>
    </div>
</div>
<div class="row"></div>
<div class="col-md-6">
    <div class="form-group">
        <label for="lbl_estado" class="col-sm-3 control-label"><?= Yii::t("formulario", "Estado") ?></label>
        <div class="col-sm-9">
            <?= Html::dropDownList("cmb_estado", -1, \app\models\Utilities::mostrarEstadoLogico(), ["class" => "form-control", "id" => "cmb_estado"]) ?>
        </div>
    </div>
</div>
<div class="row"></div>
<div>
    <?=
    PbGridView::widget([
        'id' => 'TbG_DATOS',
        'dataProvider' => $modelCita,
        //'summary' => false,
        'columns' => [
            //['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
            // format one
            //[
            //'attribute' => 'Ids',
            //'label' => 'Idst',
            //],
            // format two
            [
                'class' => 'yii\grid\ActionColumn',
                //'header' => 'Action',
                'headerOptions' => ['width' => '40'],
                'template' => '{delete}',
                'buttons' => [
                    'delete' => function ($url, $modelCita) {
                        return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:rechazarCitaProgramada(\'' . base64_encode($modelCita['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Cancelar Cita"]);
                    },
                ],
            ],
            
            [
                'header' => Yii::t("formulario", "Especialidad"),
                //'options' => ['width' => '200'],
                'value' => 'Especialidad',
            ],
            [
                //'attribute' => 'Observacion',
                'label' => 'Observación',
                //'contentOptions' => ['class' => 'table_class', 'style' => 'display:block;'],
                'options' => ['width' => '400'],
                'format' => 'raw',
                'value' => function ($modelCita) {
                    $urlReporte = Html::a((strlen($modelCita['Observacion']) < 30) ? $modelCita['Observacion'] : substr($modelCita['Observacion'], 0, 30) . ' (Ver Mas..)', null, ['href' => 'javascript:divComentario(\'' . $modelCita['Observacion'] . '\')', "data-toggle" => "tooltip", "title" => "Ver Observación"]);
                    return ($modelCita['Observacion'] != '') ? Html::decode($urlReporte) : Yii::t("formulario", "Without comments");
                },
            ],
            [
                //'attribute' => 'Estado',
                'label' => 'Estado',
                'options' => ['width' => '130'],
                'value' => function ($modelCita) {
                    return \app\models\Utilities::getEstadoLogico($modelCita['Estado']);
                },
            ],
            
        ],
    ])
?>
</div>

<div class="row"></div>