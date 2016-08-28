<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;

/* @var $this yii\web\View */
/* @var $searchModel app\models\PacienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Atención Médica';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--<div class="paciente-index">
    <h1><?= Html::encode($this->title) ?></h1>
</div>-->
<div>
    <div class="col-md-6">
        <div class="form-group">
            <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
            <div class="col-sm-9">
                <?=
                Html::dropDownList(
                        "cmb_especialidad", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($especialidades, 'esp_id', 'esp_nombre'), ["class" => "form-control", "id" => "cmb_especialidad"]
                )
                ?>
            </div>
        </div>
    </div>
</div>
<div id="div_mensOtrosUsos" class="col-md-12"></div>

<script>
    var AccionTipo='atencion';
</script>

