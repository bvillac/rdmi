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
            <h3 class="box-title pull-right">
                <?= Html::a('<span class="fa fa-fw fa-paper-plane"></span> ' . Yii::t("accion", "Enviar Solicitud"), 'javascript:', ['id' => 'btn_send', 'class' => 'btn btn-primary btn-block']); ?>
            </h3>    
        </div>
        <div class="box-body">

            <div class="col-md-12">
                <section class="experiment">
                    <h1>Conectado</h1>
                    <div id="videos-container"></div>

                    <div class="make-center">
                        <!--<input type="text" id="room-id" value="abcdef">-->
                        <button id="open-room">Iniciar Video</button>
                        <button id="join-room">Entrar Video</button>
                        <button id="open-or-join-room">Auto Open Or Join Room</button>

                        <br><br>
                        <!--<input type="text" id="input-text-chat" placeholder="Escribir Mensaje" disabled>-->
                        <button id="share-file" disabled>Compartir Archivo</button>
                        <br><br>
                        <button id="btn-leave-room" disabled>Dejar/o Cerrar la Sala</button>

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
                <span class="badge bg-yellow" title="3 New Messages" data-toggle="tooltip">3</span>
                <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i>
                </button>
                <button data-widget="chat-pane-toggle" title="" data-toggle="tooltip" class="btn btn-box-tool" type="button" data-original-title="Contacts">
                    <i class="fa fa-comments"></i></button>
                <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i>
                </button>
            </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <!-- Conversations are loaded here -->
            <div id="direct-chat-messages" class="direct-chat-messages">
                
                <!-- Message. Default to the left -->
                <div class="direct-chat-msg">
                    <div class="direct-chat-info clearfix">
                        <span class="direct-chat-name pull-left">Alexander Pierce</span>
                        <span class="direct-chat-timestamp pull-right">23 Jan 5:37 pm</span>
                    </div>
                    <!-- /.direct-chat-info -->
                    
                    <div class="direct-chat-text">
                        Working with AdminLTE on a great new app! Wanna join?
                    </div>
                    <!-- /.direct-chat-text -->
                </div>
                <!-- /.direct-chat-msg -->

                <!-- Message to the right -->
                <div class="direct-chat-msg right">
                    <div class="direct-chat-info clearfix">
                        <span class="direct-chat-name pull-right">Sarah Bullock</span>
                        <span class="direct-chat-timestamp pull-left">23 Jan 6:10 pm</span>
                    </div>
                    <!-- /.direct-chat-info -->                    
                    <div class="direct-chat-text">
                        I would love to.
                    </div>
                    <!-- /.direct-chat-text -->
                </div>
                <!-- /.direct-chat-msg -->

            </div>
            <!--/.direct-chat-messages-->

            <!-- Contacts are loaded here -->
<!--            <div class="direct-chat-contacts">
                <ul class="contacts-list">
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user1-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    Count Dracula
                                    <small class="contacts-list-date pull-right">2/28/2015</small>
                                </span>
                                <span class="contacts-list-msg">How have you been? I was...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user7-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    Sarah Doe
                                    <small class="contacts-list-date pull-right">2/23/2015</small>
                                </span>
                                <span class="contacts-list-msg">I will be waiting for...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user3-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    Nadia Jolie
                                    <small class="contacts-list-date pull-right">2/20/2015</small>
                                </span>
                                <span class="contacts-list-msg">I'll call you back at...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user5-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    Nora S. Vans
                                    <small class="contacts-list-date pull-right">2/10/2015</small>
                                </span>
                                <span class="contacts-list-msg">Where is your new...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user6-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    John K.
                                    <small class="contacts-list-date pull-right">1/27/2015</small>
                                </span>
                                <span class="contacts-list-msg">Can I take a look at...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                    <li>
                        <a href="#">
                            <img alt="User Image" src="dist/img/user8-128x128.jpg" class="contacts-list-img">

                            <div class="contacts-list-info">
                                <span class="contacts-list-name">
                                    Kenneth M.
                                    <small class="contacts-list-date pull-right">1/4/2015</small>
                                </span>
                                <span class="contacts-list-msg">Never mind I found...</span>
                            </div>
                             /.contacts-list-info 
                        </a>
                    </li>
                     End Contact Item 
                </ul>
                 /.contatcts-list 
            </div>-->
            <!-- /.direct-chat-pane -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">            
            <div class="input-group">
                <!--<input type="text" class="form-control" placeholder="Type Message ..." name="message">-->
                <input type="text" id="input-text-chat" class="form-control" placeholder="Escribir Mensaje..." disabled>
                <span class="input-group-btn">
                    <button class="btn btn-warning btn-flat" type="button">Send</button>
                </span>
            </div>
        </div>
        <!-- /.box-footer-->
    </div>


</div>
<script>
    var AccionTipo = '';
</script>


