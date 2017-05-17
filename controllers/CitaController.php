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
        $data=null;
        if (Yii::$app->request->isAjax) {//
            $data = Yii::$app->request->get();//&& $data["op"]=='1'
            if (isset($data["op"]) && $data["op"]=='1' ) {                
                CitaMedica::consultarCitasGeneral($data);
            }
        }
        return $this->render('index', [
              "model" => CitaMedica::consultarCitasGeneral($data),
        ]);
    }
    
    public function actionAnularcita() {
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $resul = CitaMedica::anularCitaMedica($data);
            if ($resul['status']) {
                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message,$resul);
            }else{
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }
            return;
        }
    }


}
