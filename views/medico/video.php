<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\GridView;
use app\assets\WebRtcAsset;

//namespace app\commands;
//use consik\yii2websocket\WebSocketServer;
//use yii\console\Controller;


/* @var $this yii\web\View */
/* @var $searchModel app\models\PacienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Video Conferencìa';
$this->params['breadcrumbs'][] = $this->title;
?>
<!--<div class="paciente-index">
    <h1><?= Html::encode($this->title) ?></h1>
<?php // echo $this->render('_search', ['model' => $searchModel]);  ?>
</div>-->

<div class="col-md-8">
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 id="infoVideo" class="box-title">Video</h3>
            <div class="box-tools pull-right">

            </div>
        </div>
        <div class="box-body">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="cmb_listaContacto" class="col-sm-3 control-label"><?= Yii::t("formulario", "Pacientes") ?></label>
                    <div class="col-sm-9">
                        <?=
                        Html::dropDownList(
                                "cmb_listaContacto", 0, ['0' => Yii::t('formulario', '-Select-')] + ArrayHelper::map(\app\models\Imagenes::getTipoImagenesAll(), 'Ids', 'Nombre'), ["class" => "form-control", "id" => "cmb_listaContacto"]
                        )
                        ?>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <!--<div class="alert alert-success alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <h4><i class="icon fa fa-check"></i> Alert!</h4>
                Success alert preview. This alert is dismissable.
                </div>-->
                <section class="experiment">
<!--                    <h3>Video</h3>-->
                    <div id="videos-container"></div>
                    <br>
                    <div class="make-center">
                        <!--<input type="text" id="room-id" value="abcdef">-->
                        <!--<button id="open-room">Iniciar Video</button>-->
                        <button id="open-room" class="btn btn-app" type="button"><i class="fa fa-video-camera"></i>Video</button>
                        <!--<button id="join-room">Entrar Video</button>-->
                        <button id="join-room" class="btn btn-app" type="button"><i class="fa fa-user"></i>Iniciar</button>
                        <!--<button id="open-or-join-room">Auto Open Or Join Room</button>-->
                        <button id="open-or-join-room" class="btn btn-app" type="button"><i class="fa fa-users"></i>Entrar</button>
                        <!--<button id="btn-leave-room" disabled>Dejar/o Cerrar la Sala</button>-->
                        <button id="btn-leave-room" class="btn btn-app" type="button"><i class="fa fa-stop"></i>Cerrar Video</button>

<!--<br><br>-->
                        <!--<input type="text" id="input-text-chat" placeholder="Escribir Mensaje" disabled>-->
                        <!--<button id="share-file" disabled>Compartir Archivo</button>-->
<!--<br><br>-->
                        

                        <div id="room-urls" style="text-align: center;display: none;background: #F1EDED;margin: 15px -10px;border: 1px solid rgb(189, 189, 189);border-left: 0;border-right: 0;"></div>
                    </div>

                    <div id="chat-container">
                        <div id="file-container"></div>
                        <div class="chat-output"></div>
                    </div>


                </section>
            </div>

        </div>
        <!-- /.box-body -->
    </div>
</div>

<div class="col-md-4">

    <div class="box box-warning direct-chat direct-chat-warning">
        <div class="box-header with-border">
            <h3 class="box-title">Chat</h3>
            <div class="box-tools pull-right">
                <!--<span class="badge bg-yellow" title="3 New Messages" data-toggle="tooltip">3</span>
                <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i></button>
                <button data-widget="chat-pane-toggle" title="" data-toggle="tooltip" class="btn btn-box-tool" type="button" data-original-title="Contacts">
                    <i class="fa fa-comments"></i></button>
                <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i></button>-->
            </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <!-- Conversations are loaded here -->
            <div id="direct-chat-messages" class="direct-chat-messages">
                
                <!-- Message. Default to the left -->
<!--                <div class="direct-chat-msg right">
                    <div class="direct-chat-info clearfix">
                        <span class="direct-chat-name pull-right">Admin</span>
                        <span class="direct-chat-timestamp pull-left">23 Jan 5:37 pm</span>
                    </div>
                     /.direct-chat-info 
                    
                    <div class="direct-chat-text">
                        Hola Usuario
                    </div>
                     /.direct-chat-text 
                </div>-->
                <!-- /.direct-chat-msg -->

                

            </div>
            <!--/.direct-chat-messages-->

        </div>
        <!-- /.box-body -->
        <div class="box-footer">            
            <div class="input-group">
                <!--<input type="text" class="form-control" placeholder="Type Message ..." name="message">-->
                <input type="text" id="input-text-chat" class="form-control" placeholder="Escribir Mensaje..." disabled>
                <span class="input-group-btn">
                    <button id="send-text" class="btn btn-warning btn-flat" type="button">Enviar</button>
                </span>
            </div>
        </div>
        <!-- /.box-footer-->
    </div>


</div>
<script>
    var AccionTipo = '';
</script>


