<?php
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Citas Pacientes") ?></h3>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="lbl_estado" class="col-sm-3 control-label"><?= Yii::t("formulario", "Search") ?></label>
        <div class="col-sm-9">
            <?=
            AutoComplete::widget([
                'name' => 'txt_buscarData',
                'id' => 'txt_buscarData',
                'clientOptions' => [
                    'autoFill' => true,
                    'minLength' => '3',
                    'source' => new JsExpression("function( request, response ) {
                            autocompletarBuscarPersona(request, response,'txt_buscarData','COD-NOM');
                     }"),
                    'select' => new JsExpression("function( event, ui ) {
                            //alert(ui.item.id);
                            //actualizaBuscarPersona(ui.item.PER_ID); 
                            $('#txth_ids').val(ui.item.Cedula);
                            //actualizarGrid();
                     }")
                ],
                'options' => [
                    'class' => 'form-control',
                    'Onkeyup' => 'clearGrid()',
                    'placeholder' => Yii::t("formulario", "Buscar por Nombres o DNI")
                ],
            ]);
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_per_nombre" class="col-sm-3 control-label"><?= Yii::t("perfil", "First Name") ?></label>
        <div class="col-sm-9">
            <input type="text" class="form-control" id="txt_per_nombre" data-type="alfa" data-keydown="true" placeholder="<?= Yii::t("perfil", "First Name") ?>">
        </div>
    </div>
</div>

<div class="col-md-6">
    <div class="form-group">
        <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
        <div class="col-sm-9">
            <?=
            Html::dropDownList(
                    "cmb_especialidad", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($especialidades, 'IdsEsp', 'Especialidad'), ["class" => "form-control", "id" => "cmb_especialidad"]
            )
            ?>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-group">
        <label for="txt_observacion" class="col-sm-3 control-label"><?= Yii::t("formulario", "Observación") ?></label>
        <div class="col-sm-9">
            <textarea id="txt_observacion" rows="2" placeholder="<?= Yii::t("formulario", "Observación") ?>" class="form-control input-sm"></textarea>
        </div>
    </div>
</div>


<div class="col-md-6">
    <div class="col-sm-4">                
        <a id="cmd_saveHora" href="javascript:" class="btn btn-primary btn-block"> <?= Yii::t("formulario", "Guardar") ?> <span class="glyphicon "></span></a>
    </div>
</div>

<div class="row"></div>