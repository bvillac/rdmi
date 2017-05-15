<?php
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
?>




<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_peso" class="col-sm-3 control-label"><?= Yii::t("formulario", "Peso") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_peso" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Peso de la Persona") ?>">
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_talla" class="col-sm-3 control-label"><?= Yii::t("formulario", "Talla") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_talla" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Talla de la Persona") ?>">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_presion_arteriar" class="col-sm-3 control-label"><?= Yii::t("formulario", "Presion") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_presion_arteriar" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Presion Arteriar") ?>">
        </div>
    </div>
</div>


<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_temperatura" class="col-sm-3 control-label"><?= Yii::t("formulario", "Corporal") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_temperatura" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Temperatura de la Persona") ?>">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_temperatura_axilar" class="col-sm-3 control-label"><?= Yii::t("formulario", "Axilar") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_temperatura_axilar" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Temperatura Axilar") ?>">
        </div>
    </div>
</div>


<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_frecuencia_respiratoria" class="col-sm-3 control-label"><?= Yii::t("formulario", "Respiratoria") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_frecuencia_respiratoria" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Frecuencia Respiratoria") ?>">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_frecuencia_cardiaca" class="col-sm-3 control-label"><?= Yii::t("formulario", "Cardiaca") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_svit_frecuencia_cardiaca" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Frecuencia Cardiaca") ?>">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="txt_svit_observacion" class="col-sm-3 control-label"><?= Yii::t("formulario", "Observación") ?></label>
        <div class="col-sm-9">
            <textarea class="form-control PBvalidation keyupmce" rows="2"  id="txt_svit_observacion" data-type="all" data-keydown="true" placeholder="<?= Yii::t("formulario", "Observación") ?>"></textarea>
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="col-sm-12">                
<!--        <a id="cmd_save" href="javascript:" class="btn btn-primary btn-block"> <?= Yii::t("formulario", "Guardar") ?> <span class="glyphicon "></span></a>-->
        <?= Html::a('<span class="glyphicon glyphicon-floppy-disk"></span> ' . Yii::t("accion", "Save"), 'javascript:', ['id' => 'btn_save','class' => 'btn btn-primary btn-block']); ?>
    </div>
</div>