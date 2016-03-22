<?php

use yii\helpers\Url;
use app\models\Rol;
use yii\helpers\Html;
?>
<?= Html::hiddenInput('txth_ftem_id','',['id' =>'txth_ftem_id']); ?>
<div class="col-md-12">
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs">
            <li class="active">             
                <a href="#paso1" data-toggle="tab" aria-expanded="true">
<!--                    <img class="" src="<?= Url::home() ?>img/users/n1.png" alt="User Image">-->
                    <?= Yii::t("Perfil", "Personal data") ?>
                </a>
            </li>
<!--            <li class=""><a href="#paso2" data-toggle="tab" aria-expanded="false"><?= Yii::t("Perfil", "Objetivo") ?></a></li>
            <li class=""><a href="#paso3" data-toggle="tab" aria-expanded="false"><?= Yii::t("Perfil", "Uso") ?></a></li>-->
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
                    <?php 
                    /*$this->render('_form_tab2', 
                        ['provincias' => $provincias,
                         'pais' => $pais,
                         'trayectoria' => $trayectoria,
                         'subobjetivos' => $subobjetivos,
                        'objetivos' => $objetivos]);*/ ?>
                </form>
            </div><!-- /.tab-pane -->
            <div class="tab-pane" id="paso3">
                <form class="form-horizontal">
                    <?php /*$this->render('_form_tab3', ['usomarca' => $usomarca,
                        'detProducto' => $detProducto,
                        'porcentaje' => $porcentaje]);*/ ?>
                </form>
            </div><!-- /.tab-pane -->

        </div><!-- /.tab-content -->
    </div><!-- /.nav-tabs-custom -->
</div><!-- /.col -->

<div class="col-md-2">
    <p><?= Html::a('<span class="glyphicon glyphicon-floppy-disk"></span>' . Yii::t("accion", "Save"), 'javascript:sentPassword()', ['class' => 'btn btn-primary btn-block']); ?> </p>
</div>
<script>
    //Datos de Solicitud
    //var varSolicitud=base64_decode('<?= $solicitud ?>');
    //var AccionTipo='Update';
    var varPerData=<?= $persona ?>;
    //var varnivelInt=<?= $nivelInt ?>;
    //var varnivelNac=<?= $nivelNac ?>;
    //var vareventos=<?= $eventos ?>;
    //var varotrousos=<?= $otrosUsos ?>;
    //var varproducto=<?= $producto ?>;
    //alert(varPerData[0].Nombre);
    
</script>
