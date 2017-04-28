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


<div class="row">
    <div class="col-md-12">
        <div id='calendar'></div>
    </div>
    
    <div class="col-md-3">
        <div class="form-group">
            <label for="lstb_especialidad_cita" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
            <div class="col-sm-12">               
                <?= Html::listBox("lstb_especialidad_cita", 0, 
                        ArrayHelper::map(app\models\Especialidad::getEspecialidadALL(), 'Ids', 'Nombre'), 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "size" => 20,
                            "id" => "lstb_especialidad_cita"])
                ?>
                <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
            </div>
        </div>        
    </div>
    <div class="col-md-3">
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

        <div class="form-group">
            <label for="lstb_centro_ate" class="col-sm-3 control-label"><?= Yii::t("formulario", "Centro/Atención") ?></label>
            <div class="col-sm-12">
                <?= Html::listBox("lstb_centro_ate", 0, ['0' => Yii::t('formulario', '-Select-')], 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "id" => "lstb_centro_ate"]) ?>
                <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
            </div>
        </div>
        <div class="form-group">
            <label for="lstb_horas_ate" class="col-sm-3 control-label"><?= Yii::t("formulario", "Horario/Atención") ?></label>
            <div class="col-sm-12">
                <?= Html::listBox("lstb_horas_ate", 0, ['0' => Yii::t('formulario', '-Select-')], 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "id" => "lstb_horas_ate"]) ?>
                <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
            </div>
        </div>
        
        
    </div>
    
    <div class="col-md-3"></div>

    
</div>
