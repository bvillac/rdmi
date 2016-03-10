<?php

namespace app\models;

use Yii;
use yii\base\Model;
use app\models\Usuario;
use app\models\Persona;
use app\models\Utilities;
use yii\helpers\Html;

/**
 * LoginForm is the model behind the login form.
 */
class ForgotpassForm extends Model
{
    public $email;
    public $verifyCode;

    private $_errorSession = false;

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            [['email'], 'required'],
            ['email','email'],
            ['email', 'string', 'min' => $minEmail],
            [['email'], 'trim'],
            ['verifyCode', 'captcha'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'email' => Yii::t('login', 'Email'),
            'verifyCode' => Yii::t('register', 'Verification Code'),
        ];
    }

    /**
     * Logs in a user using the provided username and password.
     * @return boolean whether the user is logged in successfully
     */
    public function verificarCuenta()
    {
        if ($this->validate()) { // no hay problemas de validacion
            $usuario = Usuario::findOne(['usu_username' => $this->email]);
            $passReset = new UserPassreset();
            if(isset($usuario) && $usuario->usu_estado_logico == "1" && $usuario->usu_estado_activo == "1"){
                // se trata de un usuario que no recuerda su clave
                // 1. se debe generar el link de cambio de clave
                $link = $passReset->generarLinkCambioClave($usuario->usu_id);
                if($link){
                    // 2. se debe enviar el correo
                    $persona = Persona::findIdentity($usuario->per_id);
                    $nombres = Utilities::getNombresApellidos($persona->per_nombres);
                    $tituloMensaje = Yii::t("passreset","Change Password");
                    $asunto = Yii::t("passreset", "Change Password") . " " . Yii::$app->params["siteName"];
                    $body = Utilities::getMailMessage("userpass", array("[[user]]" => $nombres[1], "[[username]]" => $this->email, "[[link_verification]]" => $link), Yii::$app->language);
                    Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$this->email => $persona->per_nombres . " " . $persona->per_apellidos], $asunto, $body);
                    // 3. mostrat mensaje de exito
                    Yii::$app->session->setFlash('success',Yii::t("passreset","<h4>Success</h4>To change your password you must access your email and follow the instructions in the mail"));
                    return true;
                }else{
                    // 2. Mostrar error
                    $this->setErrorSession(true);
                    $this->addError("error", Yii::t("exception",'The above error occurred while the Web server was processing your request.'));
                    Yii::$app->session->setFlash('error',Yii::t("exception",'The above error occurred while the Web server was processing your request.'));
                    return false;
                }
            }else{
                if(isset($usuario) && $usuario->usu_estado_logico == "1" && $usuario->usu_estado_activo == "0"){
                    // se trata de un usuario que no ha activado aun su clave 
                    // generar link de verificacion
                    $link = $usuario->generarLinkActivacion();
                    $persona = Persona::findIdentity($usuario->per_id);
                    $nombres = Utilities::getNombresApellidos($persona->per_nombres);
                    $tituloMensaje = Yii::t("register","User Activation");
                    $asunto = Yii::t("register", "User Activation") . " " . Yii::$app->params["siteName"];
                    $body = Utilities::getMailMessage("register", array("[[user]]" => $nombres[1], "[[username]]" => $this->email, "[[link_verification]]" => $link), Yii::$app->language);
                    Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$this->email => $persona->per_nombres . " " . $persona->per_apellidos], $asunto, $body);
                    // se debe mostrar mensaje de alerta que indique que se ha enviado el correo
                    Yii::$app->session->setFlash('success',Yii::t("register","<h4>Success</h4>To activate your account you must access your email and follow the instructions in the mail"));
                    return true;
                }else{
                    if(isset($usuario) && $usuario->usu_estado_logico == "0"){
                        // es una usuario desactivado
                        $this->setErrorSession(true);
                        $this->addError("error", Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                        Yii::$app->session->setFlash('error',Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                        return false;
                    }else{
                        // es otro evento no manejado
                        $this->setErrorSession(true);
                        $this->addError("error", Yii::t("login",'<h4>Error</h4>Invalid Account.'));
                        Yii::$app->session->setFlash('error',Yii::t("login",'<h4>Error</h4>Invalid Account.'));
                        return false;
                    }
                }
            }
        } else { // error de validacion
            $this->setErrorSession(true);
            $this->addError("error", Yii::t("login",'Please fill all fields'));
            Yii::$app->session->setFlash('error',Yii::t("login",'Please fill all fields'));
            return false;
        }
    }

    public function getErrorSession() {
        return $this->_errorSession;
    }

    public function setErrorSession($error){
        $this->_errorSession = $error;
    }

    public function unsetAttributes($names=null)
    {
        if($names===null)
            $names=$this->attributes();
        foreach($names as $name)
            $this->$name=null;
    }

}
