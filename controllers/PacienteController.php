<?php

namespace app\controllers;

use Yii;
use app\models\Paciente;
use app\models\PacienteSearch;
use app\models\Pais;
use app\models\Provincia;
use app\models\Canton;
use app\models\Persona;
use app\models\Usuario;
use app\models\Utilities;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * PacienteController implements the CRUD actions for Paciente model.
 */
class PacienteController extends Controller
{
    private $id_pais = 56; //Id Pertenece al Pais Ecuador
    
    public function behaviors()
    {
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
     * Lists all Paciente models.
     * @return mixed
     */
    public function actionIndex()
    {
        $data = null;
        $dataProvider = Paciente::consultarPacientes($data);
        return $this->render('index', [
                    'model' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Paciente model.
     * @param string $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Paciente model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {        
        $model = new Paciente();
        $perADO = new Persona();
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
        $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        if (count($provincias) > 0) {
            $cantones = Canton::getCantonesByProvinciaID($provincias[0]["Ids"]);
        }
        return $this->render('create', [
                    //"persona" => json_encode($perData),
                    //"especialidades" => Medico::getEspecilidades(),
                    //"empresas" => Empresa::getEmpresas(),
                    "provincias" => $provincias,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
        
    }

    /**
     * Updates an existing Paciente model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->pac_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Paciente model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param string $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Paciente model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id
     * @return Paciente the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Paciente::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
