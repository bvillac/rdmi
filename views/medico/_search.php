<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\MedicoSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="medico-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'med_id') ?>

    <?= $form->field($model, 'per_id') ?>

    <?= $form->field($model, 'med_colegiado') ?>

    <?= $form->field($model, 'med_registro') ?>

    <?= $form->field($model, 'med_est_log') ?>

    <?php // echo $form->field($model, 'med_fec_cre') ?>

    <?php // echo $form->field($model, 'med_fec_mod') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
