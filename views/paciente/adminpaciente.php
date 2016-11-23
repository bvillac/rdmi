<?php
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;

$this->title = 'Administrar Paciente '; //. ' ' . $model[0]["med_id"];

?>
<?= Html::hiddenInput('txth_med_id',$model[0]["med_id"],['id' =>'txth_med_id']); ?>
<?= Html::hiddenInput('txth_per_id',$model[0]["per_id"],['id' =>'txth_per_id']); ?>
<div class="medico-update">
    <h1><?= Html::encode($this->title) ?></h1>
</div>

<div class="col-md-12">
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#paso1" data-toggle="tab" aria-expanded="true"><?= Yii::t("perfil", "Cita Programada") ?></a></li>
            <li class=""><a href="#paso2" data-toggle="tab" aria-expanded="true"><?= Yii::t("perfil", "Agendar Cita") ?></a></li>
<!--            <li class=""><a href="#paso3" data-toggle="tab" aria-expanded="false"><?= Yii::t("perfil", "Objetivo2") ?></a></li>-->
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="paso1">
                <form class="form-horizontal">
                    <?= $this->render('_form_Admintab1', 
                        ['EspPac' => $EspPac,
                        'modelCita' => $modelCita]) ?>
                </form>
            </div><!-- /.tab-pane -->
            <div class="tab-pane" id="paso2">
                <form class="form-horizontal">
                    <?= $this->render('_form_Admintab2', 
                        ['EspPac' => $EspPac,
                        'modelCita' => $modelCita]) ?>
                </form>
                
            </div><!-- /.tab-pane -->
            
            
        </div><!-- /.tab-content -->
    </div><!-- /.nav-tabs-custom -->
</div><!-- /.col -->


<script>
    var AccionTipo='Admin';
</script>

