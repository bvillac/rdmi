<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
?>


<div class="col-md-8">
    <div class="form-group">
        <label for="lbl_Search" class="col-sm-3 control-label"><?= Yii::t("formulario", "Search") ?></label>
        <div class="col-sm-12">
            <?=
            AutoComplete::widget([
                'name' => 'txt_buscarData',
                'id' => 'txt_buscarData',
                'clientOptions' => [
                    'autoFill' => true,
                    'minLength' => '3',
                    'source' => new JsExpression("function( request, response ) {
                            autocompletarBuscarPaciente(request, response,'txt_buscarData','COD-NOM');
                     }"),
                    'select' => new JsExpression("function( event, ui ) {
                            //alert(ui.item.id);
                            //actualizaBuscarPersona(ui.item.PER_ID); 
                            $('#txth_ids').val(ui.item.Cedula);
                            //actualizarGrid();
                     }")
                ],
                'options' => [
                    'class' => 'form-control',
                    'Onkeyup' => 'clearGrid()',
                    'placeholder' => Yii::t("formulario", "Buscar por Nombres o DNI")
                ],
            ]);
            ?>
        </div>
    </div>
</div>
<div class="col-md-4">
    <div class="form-group">
        <label for="lbl_estado" class="col-sm-3 control-label"><?= Yii::t("formulario", "Estado") ?></label>
        <div class="col-sm-12">
            <?= Html::dropDownList("cmb_estado", -1, \app\models\Utilities::mostrarEstadoLogico(), ["class" => "form-control", "id" => "cmb_estado"]) ?>
        </div>
    </div>
</div>

<div class="col-md-4">
    <div class="form-group">
        <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
        <div class="col-sm-12">
            <?=
            Html::dropDownList(
                    "cmb_especialidad", 0, ['0' => Yii::t('formulario', '-Todas Especialidad-')] + ArrayHelper::map(app\models\Especialidad::getEspecialidadALL(), 'Ids', 'Nombre'), ["class" => "form-control", "id" => "cmb_especialidad"]
            )
            ?>
        </div>
    </div>
</div>

<div class="col-md-4">
    <div class="form-group">
        <label for="cmb_consultorio" class="col-sm-3 control-label"><?= Yii::t("formulario", "Consultorio") ?></label>
        <div class="col-sm-12">
            <?=
            Html::dropDownList(
                    "cmb_consultorio", 0, ['0' => Yii::t('formulario', '-Todas Consultorio-')] + ArrayHelper::map(app\models\Especialidad::getConsultorioALL(), 'Ids', 'Nombre'), ["class" => "form-control", "id" => "cmb_consultorio"]
            )
            ?>
        </div>
    </div>
</div>

<div class="col-md-4">
    <div class="form-group">
            <label for="dtp_fec_cita" class="col-sm-3 control-label"><?= Yii::t("formulario", "Fecha/Cita") ?></label>
            <div class="col-sm-12">
                <?=
                    DatePicker::widget([
                        'id' => 'dtp_fec_cita',
                        'name' => 'dtp_fec_cita',
                        'type' => DatePicker::TYPE_COMPONENT_APPEND,
                        //'value' => '23-Feb-1982',
                        'pluginOptions' => [
                            'autoclose' => true,
                            'format' => Yii::$app->params["datePickerDefault"]
                        ],
                        'options' => [
                            'class' => 'form-control',
                            //'Onchange' => 'actualizarGrid()',
                            'readonly' => 'readonly',
                            'placeholder' => Yii::t("perfil", "Fecha/Cita")//'Enter birth date ...'
                        ]
                    ]);
                ?>

            </div>
        </div>
</div>

<div class="col-md-4">
    <div class="col-sm-12">                
        <a id="cmd_buscarData" href="javascript:" class="btn btn-primary btn-block"> <span class="glyphicon glyphicon-search"></span> <?= Yii::t("formulario", "Search") ?> </a>
    </div>
</div>





