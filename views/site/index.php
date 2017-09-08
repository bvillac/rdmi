<?php
/* @var $this yii\web\View */
//$this->title = 'My Yii Application';
use yii\helpers\Html;
?>
<div class="site-index">
    <div class="jumbotron">
        <h1>Felicitaciones!</h1>

        <p class="lead">Radiografía Digital de Imagenes Médicas les da la Bienvenida (RDMI).</p>

        <h2>Heading</h2>
            <p>En estos ultimos años hemos ofrecido soluciones de radiografía médica de última 
               generación a proveedores sanitarios de todo el mundo. Ofrecemos más opciones de equipos de rayos X, 
               desde radiografía general hasta aplicaciones de consultas especializadas, tales como mamografía y 
               otorrinolaringología. Nuestros sistemas flexibles de radiografía digital, radiografía computarizada 
               e impresión médica y de película solucionan los retos de flujo de trabajo, presupuesto y espacio, a 
               la vez reducen los tiempos de los procedimientos. </p>
            
            <img src="<?= Html::encode($directoryAsset . "/img/logos/logov_".Yii::$app->language.".png") ?>" alt="logo" />
    </div>

    <div class="body-content">

        <div class="row">
            <div class="col-lg-6">
                
            </div>
        </div>

    </div>
</div>
