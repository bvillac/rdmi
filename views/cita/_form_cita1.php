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