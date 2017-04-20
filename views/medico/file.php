<?php
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;

$this->title = Yii::t('application', 'Upload and Download Files'); //. ' ' . $model[0]["med_id"];
?>

<?= Html::hiddenInput('txth_cedula','',['id' =>'txth_cedula']); ?>
<?= Html::hiddenInput('txth_ids','',['id' =>'txth_ids']); ?>
<div class="col-md-12">
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#paso1" data-toggle="tab" aria-expanded="true"><?= Yii::t("perfil", "Datos de Imagenes") ?></a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="paso1">
                <form class="form-horizontal">
                    <?= $this->render('_file_header', 
                        ['especialidades' => 0,
                        'empresas' => 0]) ?>
                </form>
            </div><!-- /.tab-pane -->
        </div><!-- /.tab-content -->
    </div><!-- /.nav-tabs-custom -->
</div><!-- /.col -->

<script>
    var AccionTipo='AccFile';
</script>




