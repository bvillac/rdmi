<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\PacienteSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="paciente-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'pac_id') ?>

    <?= $form->field($model, 'per_id') ?>

    <?= $form->field($model, 'pac_fecha_ingreso') ?>

    <?= $form->field($model, 'pac_est_log') ?>

    <?= $form->field($model, 'pac_fec_cre') ?>

    <?php // echo $form->field($model, 'pac_fec_mod') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
