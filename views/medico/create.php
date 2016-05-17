<?php

use yii\helpers\Html;
use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $model app\models\Medico */

$this->title = 'Crear Médico';
$this->params['breadcrumbs'][] = ['label' => 'Medicos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="medico-create">
    <h1><?= Html::encode($this->title) ?></h1>
</div>
<div class="col-md-12">
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs">
            <li class="active">             
                <a href="#paso1" data-toggle="tab" aria-expanded="true"><?= Yii::t("Perfil", "Personal data") ?></a>
            </li>
            <li class=""><a href="#paso2" data-toggle="tab" aria-expanded="false"><?= Yii::t("Perfil", "Especialidad") ?></a></li>
<!--            <li class=""><a href="#paso3" data-toggle="tab" aria-expanded="false"><?= Yii::t("Perfil", "Objetivo2") ?></a></li>-->
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="paso1">
                <form class="form-horizontal">
                    <?=
                    $this->render('_form_tab1', [
                        'cantones' => $cantones,
                        'genero' => $genero, 
                        'estCivil' => $estCivil,
                        'provincias' => $provincias]);
                    ?>
                </form>
            </div><!-- /.tab-pane -->
            <div class="tab-pane" id="paso2">
                <form class="form-horizontal">
                    <?= 
                    $this->render('_form_tab2', 
                        ['especialidades' => $especialidades,
                        'empresas' => $empresas]); ?>
                </form>
            </div><!-- /.tab-pane -->
            
        </div><!-- /.tab-content -->
    </div><!-- /.nav-tabs-custom -->
</div><!-- /.col -->
<div class="col-md-2">
    <p><?= Html::a('<span class="glyphicon glyphicon-floppy-disk"></span> ' . Yii::t("accion", "Save"), 'javascript:', ['id' => 'btn_saveCreate','class' => 'btn btn-primary btn-block']); ?> </p>
</div>

<script>
    var AccionTipo='Create';
</script>

