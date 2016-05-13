<?php

namespace app\controllers;

use Yii;
use app\models\Medico;
use app\models\MedicoSearch;
use app\models\Pais;
use app\models\Provincia;
use app\models\Canton;
use app\models\Persona;
use app\models\Usuario;
use app\models\Utilities;
use app\models\Empresa;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * MedicoController implements the CRUD actions for Medico model.
 */
class MedicoController extends Controller {

    private $id_pais = 56; //Id Pertenece al Pais Ecuador

    public function behaviors() {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    /**
     * Lists all Medico models.
     * @return mixed
     */
    public function actionIndex() {
        $data = null;
        $Model = new Medico();
        $dataProvider = $Model->consultarMedicos($data);
        return $this->render('index', [
                    'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Medico model.
     * @param string $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Medico model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new Medico();
        $perADO = new Persona();
        $paises = Pais::getPaises();
        $provincias = array();
        $cantones = array();
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            if (isset($data["getcantones"])) {
                $cantones = Canton::getCantonesByProvinciaID($data['prov_id']);
                $message = [
                    "cantones" => $cantones,
                ];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }
        }
        //$perData = $perADO->buscarPersonaID(Yii::$app->session->get("PerId"));
        //Utilities::putMessageLogFile($perData);
        if (count($paises) > 0) {
            $provincias = Provincia::getProvinciasByPais($this->id_pais);
        }
        if (count($provincias) > 0) {
            $cantones = Canton::getCantonesByProvincia($provincias[0]["prov_id"]);
        }

        return $this->render('create', [
                    //"persona" => json_encode($perData),
                    "especialidades" => Medico::getEspecilidades(),
                    "empresas" => Empresa::getEmpresas(),
                    "provincias" => $provincias,
                    "pais" => $paises,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
    }

    /**
     * Updates an existing Medico model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id
     * @return mixed
     */
    public function actionUpdate($id) {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->med_id]);
        } else {
            return $this->render('update', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Medico model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param string $id
     * @return mixed
     */
    public function actionDelete($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Medico model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id
     * @return Medico the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = Medico::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionSavexxx() {
        if (Yii::$app->request->isAjax) {
            $model = new MceFormularioTemp;
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                $resul = $model->insertarSolicitud($data);
            } else if ($accion == "Update") {
                //Modificar Registro
                $resul = $model->actualizarSolicitud($data);
            }
            if ($resul['status']) {
                if ($accion == "Create") {
                    $source = $_SERVER['DOCUMENT_ROOT'] . Url::base() . Yii::$app->params["documentFolder"] . $resul['cedula'];
                    $target = $_SERVER['DOCUMENT_ROOT'] . Url::base() . Yii::$app->params["documentFolder"] . $resul['cedula'] . '_' . $resul['ids'];
                    rename($source, $target); //Renombrar el Directorio                    
                }

                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message, $resul);
            } else {
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }
            return;
        }
    }
    
    public function actionSavemedico() {
        if (Yii::$app->request->isAjax) {
            $model = new Medico();
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                $resul = $model->insertarMedicos($data);
            }else if($accion == "Update"){
                //Modificar Registro
                //$resul = $model->actualizarMedicos($data);                
            }
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
