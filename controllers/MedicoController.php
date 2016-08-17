<?php

namespace app\controllers;

use Yii;
use app\models\Medico;
use app\models\MedicoSearch;
use app\models\Pais;
use app\models\Provincia;
use app\models\Canton;
use app\models\Persona;
use app\models\Paciente;
use app\models\CitaMedica;
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

    /*public function behaviors() {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }*/

    /**
     * Lists all Medico models.
     * @return mixed
     */
    public function actionIndex() {
        $data = null;
        $Model = new Medico();
        $dataProvider = $Model->consultarMedicos($data);
        return $this->render('index', [
                    'model' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Medico model.
     * @param string $id
     * @return mixed
     */
    public function actionView($ids) {
        $perADO = new Persona();
        $medADO = new Medico();
        $provincias = array();
        $cantones = array();        
        
        $ids = isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $medData = $medADO->buscarMedicoID($ids);
        $medEspData = Medico::getEspecilidadesMedico($ids);
        $empData = Empresa::getEmpresaMedico($ids);
        $perData = $perADO->buscarPersonaID($medData[0]["per_id"]);
        $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        $cantones = Canton::getCantonesByProvinciaID($perData[0]["Provincia"]);
        return $this->render('view', [
                    "model" => $medData,
                    "medico" => json_encode($medData),
                    "medicoEsp" => json_encode($medEspData),
                    "medicoEmp" => json_encode($empData),
                    "persona" => json_encode($perData),
                    "especialidades" => Medico::getEspecilidades(),
                    "empresas" => Empresa::getEmpresas(),
                    "provincias" => $provincias,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
        
    }

    /**
     * Creates a new Medico model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new Medico();
        $perADO = new Persona();
        //$paises = Pais::getPaises();
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
        //if (count($paises) > 0) {
            $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        //}
        if (count($provincias) > 0) {
            $cantones = Canton::getCantonesByProvinciaID($provincias[0]["prov_id"]);
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

    public function actionUpdate($ids) {
        $perADO = new Persona();
        $medADO = new Medico();
        //$paises = Pais::getPaises();
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
        $ids = isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $medData = $medADO->buscarMedicoID($ids);
        $medEspData = Medico::getEspecilidadesMedico($ids);
        $empData = Empresa::getEmpresaMedico($ids);
        $perData = $perADO->buscarPersonaID($medData[0]["per_id"]);
        $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        if (count($provincias) > 0) {            
            $cantones = Canton::getCantonesByProvinciaID(($perData[0]["Provincia"]<>0)?$perData[0]["Provincia"]:$provincias[0]["Ids"]);
        }
        return $this->render('update', [
                    "model" => $medData,
                    "medico" => json_encode($medData),
                    "medicoEsp" => json_encode($medEspData),
                    "medicoEmp" => json_encode($empData),
                    "persona" => json_encode($perData),
                    "especialidades" => Medico::getEspecilidades(),
                    "empresas" => Empresa::getEmpresas(),
                    "provincias" => $provincias,
                    "pais" => $paises,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
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
                $resul = $model->actualizarMedicos($data);                
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
    
    public function actionEliminar() {
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $resul = Medico::eliminarMedico($data);
            if ($resul) {
                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
            }else{
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }
            return;
        }
    }
    
    public function actionAdminmedico() {
        $data = null;
        $perADO = new Persona();
        $medADO = new Medico();
        $citaADO = new CitaMedica();        
        $provincias = array();
        $cantones = array();        
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            if (isset($data["getcentro"])) {
                $message = ["centroatencion" => Empresa::getCentroMedicoEmp($data['emp_id'])];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }
            if (isset($data["getconsultorio"])) {
                $message = ["consultorio" => Empresa::getConsultorioMedicoEmp($data)];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }
            if (isset($data["gethorio"])) {
                $message = ["horarioMedico" => Medico::mostraHorarioMedico($data),
                            "horarioCentro" => Medico::mostraHorarioCentro($data)];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }
        }
        //$ids =isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $DataMed =$medADO->buscarPerId_Medico(@Yii::$app->session->get("PerId"));//Retorna Medico Segun la Sesion de la persona 
        $medData = $medADO->buscarMedicoID($DataMed[0]["med_id"]);
        $medEspData = Medico::getEspecilidadesMedico($DataMed[0]["med_id"]);
        $medEspMedico = Medico::getEspecilidades_Medico($DataMed[0]["med_id"]);
        $empData = Empresa::getEmpresaMedico($DataMed[0]["med_id"]);
        //$perData = $perADO->buscarPersonaID($medData[0]["per_id"]);
        $dataProvider = $citaADO->consultarCitasProg($data);
        return $this->render('adminmedico', [
                    "model" => $medData,
                    "modelCita" => $dataProvider,
                    //"medico" => json_encode($medData),
                    "medicoEsp" => $medEspData,
                    "medicoEmp" => $empData,
                    "medicoEmpMed" => $medEspMedico,
                    ]);
    }
    
    public function actionSavemedicohora() {
        if (Yii::$app->request->isAjax) {
            $model = new Medico();
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                $resul = $model->insertarMedicosHoras($data);
            }/*else if($accion == "Update"){
                //Modificar Registro
                $resul = $model->actualizarMedicos($data);                
            }*/
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
    
    public function actionSavemedicocita() {
        if (Yii::$app->request->isAjax) {
            $model = new \app\models\CitaMedica();
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                $resul = $model->insertarCitasMedicas($data);
            }/*else if($accion == "Update"){
                //Modificar Registro
                $resul = $model->actualizarMedicos($data);                
            }*/
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
    
    
    public function actionBuscarpacientes() {
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $valor = isset($data['valor']) ? $data['valor'] : "";
            $op = isset($data['op']) ? $data['op'] : "";
            $arrayData = array();            
            $arrayData = Paciente::retornarPersonaPaciente($valor, $op);
            echo json_encode($arrayData);
        }
    }
    
    public function actionRechazarcitaprogramada() {
        //$formulario = new MceFormularioTemp;
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $resul = CitaMedica::rechazarCitaProgramada($data);
            if ($resul['status']) {
                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message,$resul);
            }else{
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }
            
            /*if ($resul) {
                //Datos de Mail
                $ids = isset($data['ids']) ? base64_decode($data['ids']) : NULL;
                $solicitud = $formulario->getSolicitudTempID($ids);
                $userData= Usuario::getUserPersona($solicitud[0]["reg_id"]);
                $correo = ($userData[0]["Usuario"]<>'admin')?$userData[0]["Usuario"]:Yii::$app->params["adminEmail"];
                $nombres = Yii::$app->session->get("PB_nombres");//Utilities::getNombresApellidos($this->firstName);
                $tituloMensaje = Yii::t("formulario","Application Rejected");
                $url=Yii::$app->params["contactoEmail"];
                $asunto = Yii::t("formulario", "Application Rejected") . " " . Yii::$app->params["siteName"];
                $body = Utilities::getMailMessage("rejected", array("[[user]]" => $userData[0]["Nombre"],"[[url]]" => $url, "[[link]]" => Url::base(true)), Yii::$app->language);
                Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$correo => $userData[0]["Nombres"]], $asunto, $body);
                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
            }else{
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }*/
            return;
        }
    }
    
    
    
    

}
