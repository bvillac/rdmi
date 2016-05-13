<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;



/* @var $this yii\web\View */
/* @var $model app\models\Medico */

/*$this->title = 'Update Medico: ' . ' ' . $model->med_id;
$this->params['breadcrumbs'][] = ['label' => 'Medicos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->med_id, 'url' => ['view', 'id' => $model->med_id]];
$this->params['breadcrumbs'][] = 'Update';*/
?>
<?= Html::hiddenInput('txth_med_id','',['id' =>'txth_med_id']); ?>
<div class="medico-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?php // $this->render('_form', [        'model' => $model,    ]) ?>

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
    <p><?= Html::a('<span class="glyphicon glyphicon-floppy-disk"></span> ' . Yii::t("accion", "Save"), 'javascript:', ['id' => 'btn_save','class' => 'btn btn-primary btn-block']); ?> </p>
</div>

<script>
    //Datos de Solicitud
    //var varPerData=base64_decode('<?= $persona ?>');
    //var AccionTipo='Update';
    var varPerData=<?= $persona ?>;
    //alert(varPerData[0].Nombre);
</script>

