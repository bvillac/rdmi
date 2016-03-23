<?php

namespace app\controllers;

use Yii;
use app\components\CController;
use app\models\Usuario;
use app\models\Utilities;
use app\models\TipoPassword;
use app\models\Pais;
use app\models\Provincia;
use app\models\Canton;
use app\models\Persona;

class PerfilController extends CController {

    private $id_pais = 56; //Id Pertenece al Pais Ecuador

    public function actionIndex() {
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
        $perData = $perADO->buscarPersonaID(Yii::$app->session->get("PerId"));
        //Utilities::putMessageLogFile($perData);
        if (count($paises) > 0) {
            $provincias = Provincia::getProvinciasByPais($this->id_pais);
        }
        if (count($provincias) > 0) {
            $cantones = Canton::getCantonesByProvincia($provincias[0]["prov_id"]);
        }

        return $this->render('index', [
                    "persona" => json_encode($perData),
                    "provincias" => $provincias,
                    "pais" => $paises,
                    "estCivil" => Utilities::estadoCivil(),
                    "genero" => Utilities::genero(),
                    "cantones" => $cantones]);
    }

    public function actionPassword() {
        return $this->render('password');
    }

    public function actionSave() {
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            try {
                $user = Usuario::findIdentity(Yii::$app->session->get("PB_iduser"));
                if ($user) {
                    // validar que clave cumpla con la regla de seguridad
                    $tpass = TipoPassword::findIdentity(1); // get Simple Password Type
                    $minPass = 8;
                    if (Yii::$app->session->get("PB_iduser") == 1) {//admin
                        $tpass = TipoPassword::findIdentity(3); // get Simple Password Type
                    }
                    $regx = str_replace("VAR", $minPass, $tpass->tpas_validacion);
                    if (!preg_match($regx, $data["new"])) {
                        $message = array(
                            "wtmessage" => "La contraseña no cumple con el nivel de seguridad minimo 8 caracteres y de " . $tpass->tpas_descripcion,
                            "title" => Yii::t('jslang', 'Error'),
                        );
                        echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                        return;
                    }

                    // validar password
                    if ($user->validatePassword($data["current"])) {
                        // se guarda la nueva clave
                        $user->generateAuthKey(); // generacion de hash
                        $user->setPassword($data["new"]);
                        $user->save();
                        $message = array(
                            "wtmessage" => Yii::t("passreset", "Change Password Successfull"),
                            "title" => Yii::t('jslang', 'Success'),
                        );
                        echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                        return;
                    } else {
                        $message = array(
                            "wtmessage" => "La antigua contraseña no corresponde a su contraseña actual",
                            "title" => Yii::t('jslang', 'Error'),
                        );
                        echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                        return;
                    }
                } else {
                    $message = array(
                        "wtmessage" => "Acceso no Permitido",
                        "title" => Yii::t('jslang', 'Error'),
                    );
                    echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                    return;
                }
            } catch (Exception $ex) {
                $message = array(
                    "wtmessage" => "Error Interno. Vuelva a intentar",
                    "title" => Yii::t('jslang', 'Error'),
                );
                echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                return;
            }
        }
    }
    
    public function actionSaveperfil() {
        if (Yii::$app->request->isAjax) {
            $model = new Persona();
            $data = Yii::$app->request->post();
            $accion = isset($data['ACCION']) ? $data['ACCION'] : "";
            if ($accion == "Create") {
                //Nuevo Registro
                //$resul = $model->insertarSolicitud($data);
            }else if($accion == "Update"){
                //Modificar Registro
                $resul = $model->actualizarPerfilPersona($data);                
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
