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
class ChangepassForm extends Model
{
    public $password;
    public $password_repeat;
    public $verifyCode;

    private $_errorSession = false;

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        // se debe sacar la validacion de la expresion simple
        $tpass = TipoPassword::findIdentity(1);// get Simple Password Type
        $minPass = 8;
        return [
            [['password_repeat', 'password'], 'required'],
            ['password', 'string', 'min' => $minPass, ],
            ['password', 'match', 'pattern' => str_replace("VAR", $minPass, $tpass->tpas_validacion), 'message' => Yii::t('tipopassword','Password must be uppercase and lowercase')],
            ['password_repeat','safe'],
            ['password_repeat', 'compare', 'compareAttribute' => 'password'],
            ['verifyCode', 'captcha'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'password' => Yii::t('login', 'Password'),
            'password_repeat' => Yii::t('login', 'Confirm Password'),
            'verifyCode' => Yii::t('register', 'Verification Code'),
        ];
    }

    /**
     * Logs in a user using the provided username and password.
     * @return boolean whether the user is logged in successfully
     */
    public function resetearClave($link)
    {
        if ($this->validate()) { // no hay problemas de validacion
            // se debe buscar el id del usuario a traves del link de activacion
            if($this->password == $this->password_repeat){
                $user_pass = UserPassreset::findOne(['upas_link' => $link, 'upas_estado_activo' => 1, 'upas_estado_logico' => 1]);
                $usuario = Usuario::findIdentity($user_pass->usu_id);
                if(isset($usuario) && $usuario->usu_estado_logico == "1" && $usuario->usu_estado_activo == "1"){
                    $usuario->generateAuthKey();// generacion de hash
                    $usuario->setPassword($this->password);
                    $usuario->save();
                    $user_pass->upas_estado_activo = 0;
                    $user_pass->upas_remote_ip_activo = Utilities::getClientRealIP();
                    $user_pass->upas_fecha_fin = date("Y-m-d H:i:s");
                    $user_pass->save();
                    // send email
                    $persona = Persona::findIdentity($usuario->per_id);
                    $nombres = Utilities::getNombresApellidos($persona->per_nombres);
                    $tituloMensaje = Yii::t("passreset","Change Password Successfull");
                    $asunto = Yii::t("passreset", "Change Password Successfull") . " " . Yii::$app->params["siteName"];
                    $body = Utilities::getMailMessage("changepassword", array("[[user]]" => $nombres[1], "[[username]]" => $usuario->usu_username, "[[webmail]]" => Yii::$app->params["adminEmail"]), Yii::$app->language);
                    Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$usuario->usu_username => $persona->per_nombres . " " . $persona->per_apellidos], $asunto, $body);
                    Yii::$app->session->setFlash('success',Yii::t("passreset","<h4>Success</h4>Password has been updated successfully"));
                    return true;
                }else{
                    $this->addError("error", Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                    Yii::$app->session->setFlash('error',Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                    return false;
                }
            }else{
                $this->addError("error", Yii::t("login",'Please fill all fields'));
                Yii::$app->session->setFlash('error',Yii::t("login",'Please fill all fields'));
                return false;
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
