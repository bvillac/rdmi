<?php
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use kartik\file\FileInput;
use yii\helpers\Url;
use kartik\date\DatePicker;

?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Information person") ?></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="txt_per_nombre" class="col-sm-3 control-label"><?= Yii::t("perfil", "First Name") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_per_nombre" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "First Name") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_per_apellido" class="col-sm-3 control-label"><?= Yii::t("perfil", "Last Name") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_per_apellido" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "Last Name") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_per_ced_ruc" class="col-sm-3 control-label"><?= Yii::t("perfil", "DNI") ?></label>
        <div class="col-sm-9">
            <input type="text" maxlength="10" class="form-control PBvalidation keyupmce" id="txt_per_ced_ruc" data-type="cedula" data-keydown="true" placeholder="<?= Yii::t("perfil", "National identity document") ?>">
        </div>
    </div>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_per_genero" class="col-sm-3 control-label"><?= Yii::t("perfil", "Sex") ?></label>
        <div class="col-sm-9">
            <?= Html::dropDownList("cmb_per_genero", 0, $genero, ["class" => "form-control", "id" => "cmb_per_genero"]) ?>
        </div>
    </div>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_per_estado_civil" class="col-sm-3 control-label"><?= Yii::t("perfil", "Marital Status") ?></label>
        <div class="col-sm-9">
            <?= Html::dropDownList("cmb_per_estado_civil", 0, $estCivil, ["class" => "form-control", "id" => "cmb_per_estado_civil"]) ?>
        </div>
    </div>
</div>


<div class="col-md-6">
    <div class="form-group">
        <label for="txt_per_correo" class="col-sm-3 control-label"><?= Yii::t("perfil", "Email") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation" id="txt_per_correo" data-type="email" data-keydown="true" placeholder="<?= Yii::t("perfil", "Email") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="dtp_per_fecha_nacimiento" class="col-sm-3 control-label"><?= Yii::t("perfil", "Birth Date") ?></label>
        <div class="col-sm-9">
            <?=
                DatePicker::widget([
                    'id' => 'dtp_per_fecha_nacimiento',
                    'name' => 'dtp_per_fecha_nacimiento',
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
                        'placeholder' => Yii::t("perfil", "Birth Date")//'Enter birth date ...'
                    ]
                ]);
                ?>
            
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_per_tipo_sangre" class="col-sm-3 control-label"><?= Yii::t("perfil", "Blood type") ?></label>
        <div class="col-sm-9">
            <?= Html::dropDownList("cmb_per_tipo_sangre", 0, app\models\Utilities::grupoSanguineo(), ["class" => "form-control", "id" => "cmb_per_tipo_sangre"]) ?>
        </div>
    </div>
</div>



<div class="col-md-12">
    <h3><span><?= Yii::t("perfil", "Place and Residence") ?></span></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_provincia" class="col-sm-3 control-label"><?= Yii::t("formulario", "State") ?></label>
        <div class="col-sm-9">
            <select id="cmb_provincia" class="form-control">
                <?php
                foreach ($provincias as $key2 => $value2) {
                    $name = $value2["prov_nombre"];
                    $id = $value2["prov_id"];
                    if ($id <> 25) {//Para No presentar TODAS
                        echo "<option value='" . $id . "'>" . $name . "</option>";
                    }
                }
                ?>
            </select>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_ciudad" class="col-sm-3 control-label"><?= Yii::t("formulario", "City") ?></label>
        <div class="col-sm-9">
            <select id="cmb_ciudad" class="form-control">
                <?php
                foreach ($cantones as $key3 => $value3) {
                    $name = $value3["can_nombre"];
                    $id = $value3["can_id"];
                    echo "<option value='" . $id . "'>" . $name . "</option>";
                }
                ?>
            </select>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_dper_direccion" class="col-sm-3 control-label"><?= Yii::t("perfil", "Address") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_dper_direccion" data-type="all" data-keydown="true" placeholder="<?= Yii::t("perfil", "Address") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_dper_telefono" class="col-sm-3 control-label"><?= Yii::t("perfil", "Phone") ?></label>
        <div class="col-sm-9">
            <input type="text" maxlength="13" class="form-control PBvalidation keyupmce"  id="txt_dper_telefono" data-type="celular" data-keydown="true" placeholder="<?= Yii::t("perfil", "Phone") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_dper_contacto" class="col-sm-3 control-label"><?= Yii::t("perfil", "Contact") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control PBvalidation keyupmce" id="txt_dper_contacto" data-type="alfanumerico" data-keydown="true" placeholder="<?= Yii::t("perfil", "Contact") ?>">
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_dper_celular" class="col-sm-3 control-label"><?= Yii::t("perfil", "CellPhone") ?></label>
        <div class="col-sm-9">
            <input type="text" maxlength="13" class="form-control PBvalidation keyupmce"  id="txt_dper_celular" data-type="celular" data-keydown="true" placeholder="<?= Yii::t("perfil", "CellPhone") ?>">
        </div>
    </div>
</div>

<div class="row"></div>