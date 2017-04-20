<?php

use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
use app\widgets\PbGridView\PbGridView;
use yii\data\ArrayDataProvider;

?>
<div class="row">
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
                                autocompletarBuscarPaciente(request, response,'txt_buscarData','COD-NOM');
                         }"),
                        'select' => new JsExpression("function( event, ui ) {
                                //alert(ui.item.id);
                                //actualizaBuscarPersona(ui.item.PER_ID); 
                                $('#txth_ids').val(ui.item.id);
                                $('#txth_cedula').val(ui.item.Cedula);
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
            <label for="cmb_tipoDicom" class="col-sm-3 control-label"><?= Yii::t("formulario", "Imagen Digital") ?></label>
            <div class="col-sm-9">
                <?=
                Html::dropDownList(
                        "cmb_tipoDicom", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map(\app\models\Imagenes::getTipoImagenesAll(), 'Ids', 'Nombre'), ["class" => "form-control", "id" => "cmb_tipoDicom"]
                )
                ?>
            </div>
        </div>
    </div>
    
    <div class="col-md-10">
        <div class="form-group">
            <label for="txt_dicom_file" class="col-sm-3 control-label"><?= Yii::t("formulario", "Imagen Dicom") ?></label>
            <div class="col-sm-9">
                <input id="txt_dicom_file" name="file" type="file" class="file-loading" >
                <?= Html::hiddenInput('txth_dicom_file', '',['id' =>'txth_dicom_file']); ?>
            </div>
        </div>
    </div>


    
</div>
