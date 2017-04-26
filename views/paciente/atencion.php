<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;
use app\widgets\PbGridView\PbGridView;
use yii\data\ArrayDataProvider;

$this->title = 'Atención Médica';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--<div class="paciente-index">
    <h1><?= Html::encode($this->title) ?></h1>
</div>-->


<div class="col-md-6">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 class="box-title pull-right">
            <?= Html::a('<span class="fa fa-fw fa-paper-plane"></span> ' . Yii::t("accion", "Enviar Solicitud"), 'javascript:', ['id' => 'btn_send','class' => 'btn btn-primary btn-block']); ?>
            </h3>    
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
            <h3 class="box-title">Médicos Asignados</h3>
        </div>
        <div class="box-body">
        <?= PbGridView::widget([
                'id' => 'TbG_DATOS',
                'dataProvider' => $model,
                //'summary' => false,
                'columns' => [
                    ['class' => 'yii\grid\SerialColumn', 'options' => ['width' => '10']],
                    // format one
                    //[
                    //    'attribute' => 'Ids',
                    //    'label' => 'Ids',
                    //],
                    [
                        'class' => 'yii\grid\ActionColumn',
                        //'header' => 'Action',
                        'headerOptions' => ['width' => '10'],
                        'template' => '{delete}',
                        'buttons' => [
                            'delete' => function ($url, $model) {
                                return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:eliminarAtencionMed(\'' . base64_encode($model['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Cancelar Atención"]);
                            },
                        ],
                    ],
                    [
                        'header' => Yii::t("formulario", "Nombres"),
                        //'options' => ['width' => '200'],
                        'value' => 'Nombres',
                    ],
                    [
                        'header' => Yii::t("formulario", "Especialidad"),
                        //'options' => ['width' => '200'],
                        'value' => function ($model) {
                            return  \app\models\Especialidad::getMedicoEspeLine($model['MedId']);
                        },
                    ],                      
                ],
        ]) ?>
        </div>
        <!-- /.box-body -->
    </div>
</div>



<script>
    var AccionTipo='atencion';
</script>

