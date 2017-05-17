<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\data\ArrayDataProvider;
use app\widgets\PbGridView\PbGridView;

$this->title = 'Cita Médica';
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="col-md-8">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 id="infoVideo" class="box-title">Ver Citas</h3>
            <div class="box-tools pull-right">

            </div>
        </div>

        <div class="col-md-12">
            <?=
                $this->render('_frm_BuscarGrid', [
                    //'usomarca' => $usomarca,
                    //'estSol' => $estSol
                ]);
            ?>            
        </div>
        
        <div class="box-body">
            <div class="col-md-12">
                
                <?=
                    PbGridView::widget([
                        'id' => 'TbG_CITA',
                        'dataProvider' => $model,
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
                                'header' => Yii::t("formulario", "Fecha"),
                                //'options' => ['width' => '200'],
                                'value' => function ($model) {
                                    return $model['Fecha'].' '.$model['Hora']; 
                                },
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
                                'header' => Yii::t("formulario", "Paciente"),
                                //'options' => ['width' => '200'],
                                'value' => 'NombrePac',
                            ],
                            [
                                'header' => Yii::t("formulario", "Doctor(a)"),
                                //'options' => ['width' => '200'],
                                'value' => 'NombreMed',
                            ],
                            [
                                //'attribute' => 'Estado',
                                'label' => 'Estado',
                                'options' => ['width' => '130'],
                                'value' => function ($model) {
                                    return \app\models\Utilities::getEstadoLogico($model['Estado']);
                                },
                            ],
                                        
                            [
                                'class' => 'yii\grid\ActionColumn',
                                //'header' => 'Action',
                                'headerOptions' => ['width' => '40'],
                                'template' => '{ok}{delete}',
                                'buttons' => [
                                    'ok' => function ($url, $model) {
                                        return Html::a('<span class="glyphicon glyphicon-ok"></span>', null, ['href' => 'javascript:anularCita(\'' . base64_encode($model['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Ingreso a Cita"]);
                                    },
                                    'delete' => function ($url, $model) {
                                        return Html::a('<span class="glyphicon glyphicon-remove"></span>', null, ['href' => 'javascript:anularCita(\'' . base64_encode($model['Ids']) . '\');', "data-toggle" => "tooltip", "title" => "Cancelar Cita"]);
                                    },
                                ],
                            ],             
                        ],
                    ])?>
            </div>
            

        </div>
        <!-- /.box-body -->
    </div>
    
</div>

<div class="col-md-4">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 id="infoVideo" class="box-title">Signos Vitales</h3>
            <div class="box-tools pull-right">

            </div>
        </div>
        <div class="box-body">
            <?=$this->render('_form_cita1', [
                //'cantones' => $cantones,
                //'provincias' => $provincias
                ]);
            ?>
            
        </div>
        <!-- /.box-body -->
    </div>
</div>