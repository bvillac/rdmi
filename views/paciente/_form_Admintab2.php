<?php

use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use kartik\date\DatePicker;
use yii\jui\AutoComplete;
use yii\web\JsExpression;
//use yii\grid\GridView;
use app\widgets\PbGridView\PbGridView;
use yii\data\ArrayDataProvider;


?>
<div class="col-md-12">
    <h3><?= Yii::t("perfil", "Citas Pacientes") ?></h3>
</div>


<div class="row">
    <div class="col-md-12">
        <div id='calendar'></div>
    </div>
    <div class="col-md-4">
        <div class="form-group">
            <label for="cmb_tipConsulta" class="col-sm-3 control-label"><?= Yii::t("formulario", "Tipo") ?></label>
            <div class="col-sm-12">
                <?=
                Html::dropDownList(
                        "cmb_tipConsulta", 0, 
                        ArrayHelper::map(\app\models\Especialidad::getTipoConsulta(), 'Ids', 'Nombre'), 
                        ["class" => "form-control", "id" => "cmb_tipConsulta"]
                )
                ?>
            </div>
        </div>
        <div class="form-group">
            <label for="dtp_fec_cita" class="col-sm-3 control-label"><?= Yii::t("formulario", "Fecha/Cita") ?></label>
            <div class="col-sm-12">
                <?=
                    DatePicker::widget([
                        'id' => 'dtp_fec_cita',
                        'name' => 'dtp_fec_cita',
                        'type' => DatePicker::TYPE_COMPONENT_APPEND,
                        //'value' => '23-Feb-1982',
                        'pluginOptions' => [
                            'autoclose' => true,
                            'format' => Yii::$app->params["datePickerDefault"]
                        ],
                        'options' => [
                            'class' => 'form-control',
                            //'Onchange' => 'actualizarGrid()',
                            'readonly' => 'readonly',
                            'placeholder' => Yii::t("perfil", "Fecha/Cita")//'Enter birth date ...'
                        ]
                    ]);
                ?>

            </div>
        </div>
        
         <div class="form-group">
            <label for="txt_motivo" class="col-sm-3 control-label"><?= Yii::t("formulario", "Motivo") ?></label>
            <div class="col-sm-12">
                <textarea class="form-control" rows="6"  id="txt_motivo" data-type="all" data-keydown="true" placeholder="<?= Yii::t("formulario", "Motivo") ?>"></textarea>
            </div>
        </div>

    </div>
    
    <div class="col-md-4">
        <div class="form-group">
            <label for="lstb_especialidad_cita" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
            <div class="col-sm-12">               
                <?= Html::listBox("lstb_especialidad_cita", 0, 
                        ArrayHelper::map(app\models\Especialidad::getEspecialidadALL(), 'Ids', 'Nombre'), 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "size" => 15,
                            "id" => "lstb_especialidad_cita"])
                ?>
            <!--<p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>-->
            </div>
        </div>        
    </div>
    <div class="col-md-4">
        

        <div class="form-group">
            <label for="lstb_centro_ate" class="col-sm-3 control-label"><?= Yii::t("formulario", "Centro/Atención") ?></label>
            <div class="col-sm-12">
                <?= Html::listBox("lstb_centro_ate", 0, ['0' => Yii::t('formulario', '-Select-')], 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "id" => "lstb_centro_ate"]) ?>
                <!--<p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>-->
            </div>
        </div>
        <div class="form-group">
            <label for="lstb_horas_ate" class="col-sm-3 control-label"><?= Yii::t("formulario", "Horario/Atención") ?></label>
            <div class="col-sm-12">
                <?= Html::listBox("lstb_horas_ate", 0, ['0' => Yii::t('formulario', '-Select-')], 
                        ["class" => "form-control", 
                            //'multiple' => 'multiple', 
                            "id" => "lstb_horas_ate"]) ?>
                <!--<p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>-->
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-12">
                <?= Html::a('<span class="glyphicon glyphicon-floppy-disk"></span> ' . Yii::t("accion", "Save"), 'javascript:', ['id' => 'cmd_saveCita','class' => 'btn btn-primary btn-block']); ?>   
            </div>
        </div>
    </div>

        
        
    

    <div class="col-md-12"> 
        <?=
        PbGridView::widget([
            'id' => 'TbG_CITA',
            'dataProvider' => $modelReserv,
            //'summary' => false,
            'columns' => [
                //['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
                // format one
                //[
                //'attribute' => 'Ids',
                //'label' => 'Idst',
                //],
                // format two
                [
                    'class' => 'yii\grid\ActionColumn',
                    //'header' => 'Action',
                    'headerOptions' => ['width' => '40'],
                    'template' => '{delete}',
                    'buttons' => [
                        'delete' => function ($url, $modelReserv) {
                            return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:rechazarCitaProgramada(\'' . base64_encode($modelReserv['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Cancelar Cita"]);
                        },
                    ],
                ],
                [
                    'header' => Yii::t("formulario", "Turno"),
                    //'options' => ['width' => '200'],
                    'value' => 'Turno',
                ],
                [
                    'header' => Yii::t("formulario", "Fecha"),
                    //'options' => ['width' => '200'],
                    'value' => 'Fecha',
                ],
                [
                    'header' => Yii::t("formulario", "Consultorio"),
                    //'options' => ['width' => '200'],
                    'value' => 'Consultorio',
                ],
                [
                    'header' => Yii::t("formulario", "Especialidad"),
                    //'options' => ['width' => '200'],
                    'value' => 'Especialidad',
                ],
                [
                    'header' => Yii::t("formulario", "Nombres"),
                    //'options' => ['width' => '200'],
                    'value' => 'Nombres',
                ],
                [
                    //'attribute' => 'Observacion',
                    'label' => 'Observación',
                    //'contentOptions' => ['class' => 'table_class', 'style' => 'display:block;'],
                    'options' => ['width' => '400'],
                    'format' => 'raw',
                    'value' => function ($modelReserv) {
                        $urlReporte = Html::a((strlen($modelReserv['Observacion']) < 30) ? $modelReserv['Observacion'] : substr($modelReserv['Observacion'], 0, 30) . ' (Ver Mas..)', null, ['href' => 'javascript:divComentario(\'' . $modelReserv['Observacion'] . '\')', "data-toggle" => "tooltip", "title" => "Ver Observación"]);
                        return ($modelReserv['Observacion'] != '') ? Html::decode($urlReporte) : Yii::t("formulario", "Without comments");
                    },
                ],
                [
                    //'attribute' => 'Estado',
                    'label' => 'Estado',
                    'options' => ['width' => '130'],
                    'value' => function ($modelReserv) {
                        return \app\models\Utilities::getEstadoLogico($modelReserv['Estado']);
                    },
                ],
            ],
        ])?>
        
    </div>


    
</div>
