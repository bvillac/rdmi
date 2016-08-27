<?php

namespace app\models;

use Yii;
use yii\base\Model;
use app\models\Usuario;
use app\models\Utilities;
use yii\helpers\Html;

/**
 * LoginForm is the model behind the login form.
 */
class RegisterForm extends Model
{
    public $email;
    public $firstName;
    public $lastName;
    public $password;
    public $password_repeat;
    public $verifyCode;

    private $_user = false;
    private $_errorSession = false;

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        // se debe sacar la validacion de la expresion simple
        $tpass = TipoPassword::findIdentity(1);// get Simple Password Type
        $minPass = 8;
        $minName = 2;
        $minEmail = 4;
        return [
            [['email', 'firstName', 'lastName', 'password_repeat', 'password'], 'required'],
            ['firstName', 'string', 'min' => $minName],
            ['lastName', 'string', 'min' => $minName],
            ['email','email'],
            ['email', 'string', 'min' => $minEmail],
            ['password', 'string', 'min' => $minPass, ],
            ['password', 'match', 'pattern' => str_replace("VAR", $minPass, $tpass->tpas_validacion), 'message' => Yii::t('tipopassword','Password must be uppercase and lowercase')],
            ['password_repeat','safe'],
            ['password_repeat', 'compare', 'compareAttribute' => 'password'],
            [['email', 'firstName', 'lastName'], 'trim'],
            ['verifyCode', 'captcha'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'email' => Yii::t('login', 'Email'),
            'firstName' => Yii::t('perfil', 'First Name'),
            'lastName' => Yii::t('perfil', 'Last Name'),
            'password' => Yii::t('login', 'Password'),
            'password_repeat' => Yii::t('login', 'Confirm Password'),
            'verifyCode' => Yii::t('register', 'Verification Code'),
        ];
    }

    /**
     * Logs in a user using the provided username and password.
     * @return boolean whether the user is logged in successfully
     */
    public function register()
    {
        if ($this->validate()) { // no hay problemas de validacion
            $usuario = Usuario::findByUsername($this->email);
            if(isset($usuario) && $usuario->usu_est_log == "1" && $usuario->usu_estado_activo == "1"){
                //Si el Correo ya existe
                $this->setErrorSession(true);
                $this->addError("error", Yii::t("register","<h4>Error</h4>Email already exists. Please choose another."));
                Yii::$app->session->setFlash('error',Yii::t("register","<h4>Error</h4>Email already exists. Please choose another."));
                return false;
            }else{
                //Las constraseñas deben ser iguales
                if($this->password !== $this->password_repeat){
                    $this->setErrorSession(true);
                    $this->addError("error", Yii::t("register","<h4>Error</h4>Password and Password Confirm are different"));
                    Yii::$app->session->setFlash('error',Yii::t("register","<h4>Error</h4>Password and Password Confirm are different"));
                    return false;
                }
                //Si pasa correctamente se Crea a la Persona y despues al usuarios
                // primero se crea a la persona
                $persona = new Persona();
                $persona->per_nombre   = Html::encode($this->firstName);
                $persona->per_apellido = Html::encode($this->lastName);
                $persona->per_correo    = Html::encode($this->email);
                if(!$persona->guardarPersonaRegistro($persona)){
                    $this->setErrorSession(true);
                    $this->addError("error", Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Yii::$app->session->setFlash('error',Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Utilities::putMessageLogFile("Error al crear la persona: ".$this->firstName." - ".$this->lastName." - ".$this->email);
                    return false;
                }
                $id_persona = $persona->per_id;
                // segundo se crea a usuario
                $usuario = new Usuario();
                if(!$usuario->crearUsuario($this->email, $this->password, $id_persona)){
                    $this->setErrorSession(true);
                    $this->addError("error", Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Yii::$app->session->setFlash('error',Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Utilities::putMessageLogFile("Error al crear al usuario: ".$this->firstName." - ".$this->lastName." - ".$this->email);
                    $persona->delete();
                    return false;
                }
                $usuario->usu_estado_activo = 0;
                if(!$usuario->update()){
                    $this->setErrorSession(true);
                    $this->addError("error", Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Yii::$app->session->setFlash('error',Yii::t("exception","<h4>Error</h4>The above error occurred while the Web server was processing your request."));
                    Utilities::putMessageLogFile("Error al crear al usuario: ".$this->firstName." - ".$this->lastName." - ".$this->email);
                    $persona->delete();
                    return false;
                }
                $usu_id = $usuario->usu_id;
                // tercero se crea los permisos del usuario con la empresa
                $emp_rol = new Rol();
                $emp_id=1;//Empresa Medical Por Defecto
                $rol_id=2;//Rol de Usuario Normal
                if(!$emp_rol->guardarEmpresaRol($usu_id,$emp_id,$rol_id)){
                    $this->addError("error", Yii::t("exception","The above error occurred while the Web server was processing your request."));
                    Yii::$app->session->setFlash('error',Yii::t("exception","The above error occurred while the Web server was processing your request."));
                    Utilities::putMessageLogFile("Error al asignar el grupo al usuario: ".$this->firstName." - ".$this->lastName." - ".$this->email);
                    $usuario->delete();
                    $persona->delete();
                    return false;
                }
                
                
                // generar link de verificacion
                $link = $usuario->generarLinkActivacion();
                
                // quinto enviar correo electronico para activacion de cuenta
                $nombres = Utilities::getNombresApellidos($this->firstName);
                $tituloMensaje = Yii::t("register","Successful Registration");
                $asunto = Yii::t("register", "User Register") . " " . Yii::$app->params["siteName"];
                $body = Utilities::getMailMessage("register", array("[[user]]" => $nombres[1], "[[username]]" => $this->email, "[[link_verification]]" => $link), Yii::$app->language);
                Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$this->email => $this->lastName . " " . $this->firstName], $asunto, $body);
                // se debe mostrar mensaje de alerta que indique que se ha enviado el correo
                Yii::$app->session->setFlash('success',Yii::t("register","<h4>Success</h4>To activate your account you must access your email and follow the instructions in the mail"));
                return true;
            }
        } else { // error de validacion
            $this->setErrorSession(true);
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
