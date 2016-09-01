<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;

/* @var $this yii\web\View */
/* @var $searchModel app\models\PacienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Atención Médica';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--<div class="paciente-index">
    <h1><?= Html::encode($this->title) ?></h1>
</div>-->


<div class="col-md-6">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 class="box-title">Especialidades</h3>
        </div>
        <div class="box-body">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="cmb_especialidad" class="col-sm-3 control-label"><?= Yii::t("formulario", "Especialidad") ?></label>
                    <div class="col-sm-9">
                        <?=
                        Html::dropDownList(
                                "cmb_especialidad", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map($especialidades, 'esp_id', 'esp_nombre'), ["class" => "form-control", "id" => "cmb_especialidad"]
                        )
                        ?>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label for="cmb_medicos" class="col-sm-3 control-label"><?= Yii::t("formulario", "Médicos") ?></label>
                    <div class="col-sm-9">
                        <?= Html::dropDownList("cmb_medicos", 0, ['0' => Yii::t('formulario', '-Select-')], ["class" => "form-control multiselect", 'multiple' => 'multiple', "id" => "cmb_medicos"]) ?>
                        <p style="margin-top:5px"><?= Yii::t("formulario", "You can select more than one option by pressing") ?></p>
                    </div>

                </div>
            </div>
        </div>
        <!-- /.box-body -->
    </div>
</div>
<div class="col-md-6">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 class="box-title">Different Height</h3>
        </div>
        <div class="box-body">
            <?=
            PbGridView::widget([
                'id' => 'TbG_DATOS',
                'dataProvider' => $modelCita,
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
                            'delete' => function ($url, $modelCita) {
                                return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:rechazarCitaProgramada(\'' . base64_encode($modelCita['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Cancelar Cita"]);
                            },
                                ],
                            ],
                            [
                                'header' => Yii::t("formulario", "Especialidad"),
                                //'options' => ['width' => '200'],
                                'value' => 'Especialidad',
                            ],
                            [
                                //'attribute' => 'Observacion',
                                'label' => 'Observación',
                                //'contentOptions' => ['class' => 'table_class', 'style' => 'display:block;'],
                                'options' => ['width' => '400'],
                                'format' => 'raw',
                                'value' => function ($modelCita) {
                            $urlReporte = Html::a((strlen($modelCita['Observacion']) < 30) ? $modelCita['Observacion'] : substr($modelCita['Observacion'], 0, 30) . ' (Ver Mas..)', null, ['href' => 'javascript:divComentario(\'' . $modelCita['Observacion'] . '\')', "data-toggle" => "tooltip", "title" => "Ver Observación"]);
                            return ($modelCita['Observacion'] != '') ? Html::decode($urlReporte) : Yii::t("formulario", "Without comments");
                        },
                            ],
                            [
                                //'attribute' => 'Estado',
                                'label' => 'Estado',
                                'options' => ['width' => '130'],
                                'value' => function ($modelCita) {
                            return \app\models\Utilities::getEstadoLogico($modelCita['Estado']);
                        },
                            ],
                        ],
                    ])
                    ?>
        </div>
        <!-- /.box-body -->
    </div>
</div>



<script>
    var AccionTipo='atencion';
</script>

