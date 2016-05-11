<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Medico */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="medico-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'per_id')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'med_colegiado')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'med_registro')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'med_est_log')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'med_fec_cre')->textInput() ?>

    <?= $form->field($model, 'med_fec_mod')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
