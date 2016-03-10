<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use app\components\CController;
use yii\filters\VerbFilter;
use app\models\Usuario;
use app\models\LoginForm;
use app\models\RegisterForm;
use app\models\ForgotpassForm;
use app\models\UserPassreset;
use app\models\ChangepassForm;
use app\models\Utilities;
use app\models\Grupo;
use app\models\MceFormularioTemp;
use app\models\Modulo;
use yii\helpers\Url;

class SiteController extends CController
{
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['login', 'logout', 'register', 'activation', 'forgotpass', 'updatepass', 'getimage'],
                'rules' => [
                    [
                        'allow' => true,
                        'actions' => ['login'],
                        'roles' => ['?', '@'], // usuarios invitados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['register'],
                        'roles' => ['?'], // usuarios invitados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['logout'],
                        'roles' => ['@'], // usuarios autenticados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['activation'],
                        'roles' => ['?'], // usuarios invitados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['forgotpass'],
                        'roles' => ['?'], // usuarios invitados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['updatepass'],
                        'roles' => ['?'], // usuarios invitados
                    ],
                    [
                        'allow' => true,
                        'actions' => ['getimage'],
                        'roles' => ['?','@'], // usuarios invitados
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post', 'get'],
                ],
            ],
        ];
    }

    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'app\components\CCaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    public function actionIndex()
    {
        if (\Yii::$app->user->isGuest) {
            return $this->redirect(Url::base(true).'/site/login');
        }
        // setting default url
        $mod = new Modulo();
        $link =  $mod->getFirstModuleLink();
        $url = Url::base(true) . "/" . $link["url"];
        return $this->goBack($url);
        //return $this->render('index');
    }

    public function actionLogin()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->redirect(Url::base(true).'/site/login');
        }
        $model = new LoginForm();
        
        if(Yii::$app->session->get("PB_isuser", false)){
            // setting default url
            $mod = new Modulo();
            $link =  $mod->getFirstModuleLink();
            $url = Url::base(true) . "/" . $link["url"];
            return $this->goBack($url);
        }
        
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            // setting default url
            $mod = new Modulo();
            $link =  $mod->getFirstModuleLink();
            $url = Url::base(true) . "/" . $link["url"];
            return $this->goBack($url);
        } else {
            if($model->getErrorSession())
                Yii::$app->session->setFlash('loginFormSubmitted');
            return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/login.php', [
                'model' => $model,
            ]);
        }
    }

    public function actionLogout()
    {
        $usuario = new Usuario();
        $usuario->destroySession();
        Yii::$app->user->logout();
        return $this->redirect(Url::base(true).'/site/login');
    }

    public function actionRegister()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->redirect(Url::base(true).'/site/login');
        }
        
        $model = new RegisterForm();
        if ($model->load(Yii::$app->request->post()) && $model->register()) {
            // se limpia los campos
            $model->unsetAttributes();
            return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/register.php', [
                'model' => $model,
            ]);
        } else {
            if($model->getErrorSession())
                Yii::$app->session->setFlash('registerFormSubmitted');
            return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/register.php', [
                'model' => $model,
            ]);
        }
    }
    
    public function actionActivation()
    {
        $data = Yii::$app->request->get();
        if(isset($data["wg"])){
            $usuario = new Usuario();
            
            $status = $usuario->activarLinkCuenta(Url::base(true)."/site/activation?wg=".$data["wg"]);
            if($status){
                Yii::$app->session->setFlash('success',Yii::t("login","<h4>Success</h4>Account is enabled. Please enter your email and password."));
                return $this->redirect(Url::base(true).'/site/login');
            }else{
                $model = new LoginForm();
                Yii::$app->session->setFlash('error',Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                return $this->redirect(Url::base(true).'/site/login');
            }
        }
    }
    
    public function actionForgotpass()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->redirect(Url::base(true).'/site/login');
        }
        $model = new ForgotpassForm();
        if ($model->load(Yii::$app->request->post()) && $model->verificarCuenta()) {
            // se limpia los campos
            $model->unsetAttributes();
            return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/forgot.php', [
                'model' => $model,
            ]);
        } else {
            if($model->getErrorSession())
                Yii::$app->session->setFlash('forgotFormSubmitted');
            return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/forgot.php', [
                'model' => $model,
            ]);
        }
    }
    
    public function actionUpdatepass()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->redirect(Url::base(true).'/site/login');
        }
        $data = Yii::$app->request->get();
        if(isset($data["wg"])){
            $userpass = new UserPassreset();
            $status = $userpass->verificarLinkCambioClave(Url::base(true)."/site/updatepass?wg=".$data["wg"]);
            if($status){
                $model = new ChangepassForm();
                if ($model->load(Yii::$app->request->post()) && $model->resetearClave(Url::base(true)."/site/updatepass?wg=".$data["wg"])) {
                    // se limpia los campos
                    $model->unsetAttributes();
                    return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/changepass.php', [
                        'model' => $model,
                    ]);
                } else {
                    if($model->getErrorSession())
                        Yii::$app->session->setFlash('updatepassFormSubmitted');
                    return $this->renderFile('@themes/' . \Yii::$app->getView()->theme->themeName . '/layouts/changepass.php', [
                        'model' => $model,
                    ]);
                }
            }else{
                Yii::$app->session->setFlash('error',Yii::t("login","<h4>Error</h4>Account is disabled. Please confirm the account with link activation in your email account or reset your password."));
                return $this->redirect('login');
            }
            
        }
    }
    
    /**
     * Get image from route
     *
     * @author Eduardo Cueva
     * @access protected
     * @param string $route     Ruta de Imagen
     */
    public function actionGetimage($route) {
        $grupo = new Grupo();
        if(Yii::$app->session->get('PB_isuser')){
            $data = $grupo->getMainGrupo(Yii::$app->session->get('PB_username'));
            $route = str_replace("../", "", $route);
            if($data["id"] == 2){ // Licenciatario
                $formTemp = MceFormularioTemp::findOne(["reg_id" => Yii::$app->session->get('PB_idregister'), "ftem_estado_logico" => 1]);
                $reg = "/\/".$formTemp->ftem_cedula."(_.+)?\//";
                //if(preg_match($reg, $route)){
                if(preg_match("/uploads\//", $route)){
                    $url_image = Yii::$app->basePath . $route;
                    $arrIm = explode(".", $url_image);
                    $typeImage = $arrIm[count($arrIm) - 1];
                    if (file_exists($url_image)) {
                        if (strtolower($typeImage) == "png") {
                            Header("Content-type: image/png");
                            $im = imagecreatefromPng($url_image);
                            ImagePng($im); // Mostramos la imagen 
                            ImageDestroy($im); // Liberamos la memoria que ocupaba la imagen 
                        } elseif(strtolower($typeImage) == "jpg" || strtolower($typeImage) == "jpeg") {
                            Header("Content-type: image/jpeg");
                            $im = imagecreatefromJpeg($url_image);
                            ImageJpeg($im); // Mostramos la imagen 
                            ImageDestroy($im); // Liberamos la memoria que ocupaba la imagen 
                        } elseif(strtolower($typeImage) == "pdf") {
                            Header("Content-type: application/pdf");
                            echo file_get_contents($url_image);
                        }
                        return;
                    }
                }
                //}
            }elseif($data["id"] == 1){ // Admin
                $url_image = Yii::$app->basePath . $route;
                $arrIm = explode(".", $url_image);
                $typeImage = $arrIm[count($arrIm) - 1];
                if (file_exists($url_image)) {
                    if (strtolower($typeImage) == "png") {
                        Header("Content-type: image/png");
                        $im = imagecreatefromPng($url_image);
                        ImagePng($im); // Mostramos la imagen 
                        ImageDestroy($im); // Liberamos la memoria que ocupaba la imagen 
                    } elseif(strtolower($typeImage) == "jpg" || strtolower($typeImage) == "jpeg") {
                        Header("Content-type: image/jpeg");
                        $im = imagecreatefromJpeg($url_image);
                        ImageJpeg($im); // Mostramos la imagen 
                        ImageDestroy($im); // Liberamos la memoria que ocupaba la imagen 
                    } elseif(strtolower($typeImage) == "pdf") {
                        Header("Content-type: application/pdf");
                        echo file_get_contents($url_image);
                    }
                    return;
                }
            }
        }
        /* Crear una imagen en blanco */
        Header("Content-type: image/png");
        $im = imagecreatetruecolor(90, 90);
        $fondo = imagecolorallocate($im, 255, 255, 255);
        $ct = imagecolorallocate($im, 0, 0, 0);
        imagefilledrectangle($im, 0, 0, 150, 30, $fondo);
        // Imprimir un mensaje de error 
        imagestring($im, 1, 5, 5, Yii::t('jslang', 'Bad Request') . ": " . $route, $ct);
        ImagePng($im); // Mostramos la imagen 
        ImageDestroy($im); // Liberamos la memoria que ocupaba la imagen 
        return;
        
    }
    
}
