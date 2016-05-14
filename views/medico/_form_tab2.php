<?php
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
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
                    "cmb_empresa", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($empresas, 'emp_id', 'emp_nombre'), ["class" => "form-control", "id" => "cmb_empresa"]
            )
            ?>
        </div>
    </div>
</div>

<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Registros Médico") ?></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="txt_med_colegiado" class="col-sm-3 control-label"><?= Yii::t("perfil", "Colegiado") ?></label>
        <div class="col-sm-9">
            <input type="text" maxlength="100" class="form-control PBvalidation keyupmce" id="txt_med_colegiado" data-type="all" data-keydown="true" placeholder="<?= Yii::t("perfil", "Colegiado") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_med_registro" class="col-sm-3 control-label"><?= Yii::t("perfil", "Registro") ?></label>
        <div class="col-sm-9">
            <input type="text" maxlength="20" class="form-control PBvalidation keyupmce" id="txt_med_registro" data-type="all" data-keydown="true" placeholder="<?= Yii::t("perfil", "Registro Médico") ?>">
        </div>
    </div>
</div>

<div class="col-md-12">
    <h3><span><?= Yii::t("perfil", "Especialidad") ?></span></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
        <div class="col-sm-9">
            <?= Html::dropDownList("cmb_especialidad", 0, ArrayHelper::map($especialidades, 'esp_id', 'esp_nombre'), ["class" => "form-control multiselect", 'multiple' => 'multiple', "id" => "cmb_especialidad"]) ?>
            <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
        </div>
    </div>
</div>

<div class="row"></div>