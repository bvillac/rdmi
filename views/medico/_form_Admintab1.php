<?php
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Información Empresa") ?></h3>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_empresa" class="col-sm-3 control-label"><?= Yii::t("perfil", "Empresa") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_empresa", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($empresas, 'IdsEmp', 'Empresa'), ["class" => "form-control", "id" => "cmb_empresa"]
            )
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_centro" class="col-sm-3 control-label"><?= Yii::t("perfil", "Centro Atención") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_centro", 0, ['0' => Yii::t('formulario', '-Select-')] , ["class" => "form-control", "id" => "cmb_centro"]
            )
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_especialidad", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($especialidades, 'IdsEsp', 'Especialidad'), ["class" => "form-control", "id" => "cmb_especialidad"]
            )
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_consultorio" class="col-sm-3 control-label"><?= Yii::t("formulario", "Consultorio") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_consultorio", 0, ['0' => Yii::t('formulario', '-Select-')] , ["class" => "form-control", "id" => "cmb_consultorio"]
            )
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="lbl_fechaHora" class="col-sm-3 control-label"><?= Yii::t("formulario", "Fecha") ?></label>
        <div class="col-sm-9">
            <?=
                DatePicker::widget([
                    'id' => 'dtp_f_medHora',
                    'name' => 'dtp_f_medHora',
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
                        'placeholder' => Yii::t("formulario", "Fecha del Turno")//'Enter birth date ...'
                    ]
                ]);
                ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="col-sm-4">
        <a id="cmd_generarHora" href="javascript:" class="btn btn-primary btn-block"> <?= Yii::t("formulario", "Generar Horas") ?> <span class="glyphicon"></span></a>
    </div>
    <div class="col-sm-4">                
        <a id="cmd_saveHora" href="javascript:" class="btn btn-primary btn-block"> <?= Yii::t("formulario", "Guardar") ?> <span class="glyphicon "></span></a>
    </div>
</div>



<div class="col-md-12">
    <h3><span><?= Yii::t("perfil", "Horarios") ?></span></h3>
    <p>
        <span id="lbl_cons_hora_inicio" class="label label-primary"></span>
        <span id="lbl_cons_hora_fin" class="label label-primary"></span>
        <span id="lbl_cons_tiempo_consulta" class="label label-primary"></span>
    </p>
</div>
<div id="info-Horarios" class="col-md-12">

</div>


<div class="row"></div>