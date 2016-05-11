<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Medico */

$this->title = 'Update Medico: ' . ' ' . $model->med_id;
$this->params['breadcrumbs'][] = ['label' => 'Medicos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->med_id, 'url' => ['view', 'id' => $model->med_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="medico-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
