<?php

namespace app\controllers;

use Yii;
use yii\helpers\Html;
use app\models\Medico;
use app\models\MedicoSearch;
use app\models\Persona;
use app\models\Paciente;
use app\models\CitaMedica;
use app\models\Usuario;
use app\models\Utilities;
use app\models\Empresa;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\helpers\Url;

/**
 * MedicoController implements the CRUD actions for Medico model.
 */
class CitaController extends Controller {

    //private $id_pais = 56; //Id Pertenece al Pais Ecuador

    
     public function actionIndex() {
        $data = null;

        return $this->render('index', [
              "model" => Paciente::consultarCitas($data),
        ]);
    }


}
