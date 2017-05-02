<?php

namespace app\controllers;

use Yii;
use app\models\Paciente;
use app\models\Medico;
use app\models\Especialidad;
use app\models\PacienteSearch;
use app\models\Pais;
use app\models\Provincia;
use app\models\Canton;
use app\models\Persona;
use app\models\CitaMedica;
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
    public function actionView($ids) {
        $perADO = new Persona();
        $pacADO = new Paciente();
        $provincias = array();
        $cantones = array();        
        
        $ids = isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $pacData = $pacADO->buscarPacienteID($ids);
        $perData = $perADO->buscarPersonaID($pacData[0]["per_id"]);
        $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        if (count($provincias) > 0) {            
            $cantones = Canton::getCantonesByProvinciaID(($perData[0]["Provincia"]<>0)?$perData[0]["Provincia"]:$provincias[0]["Ids"]);
        }
        return $this->render('view', [
                    "model" => $pacData,
                    "paciente" => json_encode($pacData),
                    "persona" => json_encode($perData),
                    "provincias" => $provincias,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
        
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
    public function actionUpdate($ids) {
        $pacADO = new Paciente();
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
        $ids = isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $pacData = $pacADO->buscarPacienteID($ids);
        $perData = $perADO->buscarPersonaID($pacData[0]["per_id"]);
        $provincias = Provincia::getProvinciasByPaisID($this->id_pais);
        if (count($provincias) > 0) {            
            $cantones = Canton::getCantonesByProvinciaID(($perData[0]["Provincia"]<>0)?$perData[0]["Provincia"]:$provincias[0]["Ids"]);
        }
        return $this->render('update', [
                    "model" => $pacData,
                    "paciente" => json_encode($pacData),
                    "persona" => json_encode($perData),
                    "provincias" => $provincias,
                    "pais" => $paises,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
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
    
    public function actionSave() {
        if (Yii::$app->request->isAjax) {
            $model = new Paciente();
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                $resul = $model->insertarPacientes($data);
            }else if($accion == "Update"){
                //Modificar Registro
                $resul = $model->actualizarPacientes($data);                
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
            $resul = Paciente::eliminarPaciente($data);
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
    
    public function actionAdminpaciente() {
        $data = null;
        $datADO = new Paciente;
        $citaADO = new CitaMedica();        
        
        if (Yii::$app->request->isAjax) {//Yii::$app->request->isPjax
            $data =(Yii::$app->request->post())? Yii::$app->request->post():Yii::$app->request->get();
            if (isset($data["centros"])) {
                $centros=CitaMedica::getCentoAtencionEspecialidad($data["esp_id"]);
                $message = [
                    "centros" => $centros,
                ];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }
            if (isset($data["horas"])) {
                $horarios=CitaMedica::getHorarioAtencion($data["cons_id"], $data["fecha_cita"]);
                $message = [
                    "horarios" => $horarios,
                ];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            }

            if (isset($data["op"]) && $data["op"]=='1' ) {                
                $datADO->consultarCitasProgPac($data);
                //return;
            }
        }
        
        //$ids =isset($_GET['ids']) ? base64_decode($_GET['ids']) : NULL;
        $DataMed =$datADO->buscarPerId_Paciente(@Yii::$app->session->get("PerId"));//Retorna Medico Segun la Sesion de la persona 
        $EspPac = Paciente::getEspePaciente($DataMed[0]["pac_id"]);

        return $this->render('adminpaciente', [
                    "modelCita" => $datADO->consultarCitasProgPac($data),
                    "modelReserv" => Paciente::consultarCitas($data),
                    //"medico" => json_encode($medData),
                    "EspPac" => $EspPac,
                    ]);
    }
    
    /**
     * Lists all Paciente models.
     * @return mixed
     */
    public function actionAtencion(){
        $data = null;
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            if (isset($data["espcialidad"])) {
                $medicos = Especialidad::getMedicoEspecialidad($data['esp_id']);
                $message = [
                    "medicos" => $medicos,
                ];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                return;
            } 
        }
        //Utilities::putMessageLogFile(Medico::getEspecilidades());
        return $this->render('atencion', [
            "model" => Paciente::atencionPacMedico($data),
            "especialidades" => Medico::getEspecilidades(),
        ]);
    }
    
    public function actionEliminaratencionmed() {
        //$formulario = new MceFormularioTemp;
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $resul = Medico::eliminarAtencionMedico($data);
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
            }*/
            return;
        }
    }
    
    public function actionSolicitudatencion() {
        $perADO = new Persona();
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            $resul = Medico::solicitarAtencionMedico($data);
            if ($resul['status']) {                
                //Datos de Mail   
                $dtsData=Medico::mostraMedicoCorreoGrupo($resul['MedData']);
                $dataPaciente=$perADO->buscarPersonaID(Yii::$app->session->get('PerId', FALSE));//Recupera Datos de la Persona
                for ($i = 0; $i < sizeof($dtsData); $i++) { 
                    $correo = $dtsData[$i]["Correo"];//($userData[0]["Usuario"]<>'admin')?$userData[0]["Usuario"]:Yii::$app->params["adminEmail"];
                    $nombres = $dtsData[$i]["Nombre"];
                    $tituloMensaje = Yii::t("formulario","Solicitud de Atención");
                    //$url=Yii::$app->params["contactoEmail"];
                    $asunto = Yii::t("formulario","Solicitud de Atención") . " " . Yii::$app->params["siteName"];
                    $body = Utilities::getMailMessage("solicitudmedica", 
                            array("[[PacienteNombre]]" => $dataPaciente[0]["Nombre"].' '.$dataPaciente[0]["Apellido"],
                                  "[[DNI]]" => $dataPaciente[0]["Cedula"], 
                                  "[[Direccion]]" =>$dataPaciente[0]["Direccion"]
                                  //"[[link]]" => Url::base(true)
                            ), Yii::$app->language);
                    Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"],
                                        [$correo => $dtsData[$i]["Correo"]], 
                                        [],//Bcc
                                        $asunto, $body);
                }

                $message = ["info" => Yii::t('exception', '<strong>Well done!</strong> your information was successfully saved.')];
                echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message,$resul);
            }else{
                $message = ["info" => Yii::t('exception', 'The above error occurred while the Web server was processing your request.')];
                echo Utilities::ajaxResponse('NO_OK', 'alert', Yii::t('jslang', 'Error'), 'false', $message);
            }
            
            
            return;
        }
    }
    
    public function actionVideo()
    {
        //$data = null;
        //$dataProvider = Paciente::consultarPacientes($data);
        return $this->render('video', [
                    //'model' => $dataProvider,
        ]);
    }
    
    
    public function actionSendmessage() {
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            //Utilities::putMessageLogFile($data);
            $name=$data["name"];
            $message=$data["message"];//json_encode
            //Ejecutar y Enviar la Info al Servidor
            return Yii::$app->redis->executeCommand('PUBLISH', [
                'channel' => 'notification',
                'message' => json_encode(['name' => $name, 'message' => $message])
            ]);
        }
         return $this->render('video');
    }
    

}
