<?php

/*
 * The PenBlu framework is free software. It is released under the terms of
 * the following BSD License.
 *
 * Copyright (C) 2015 by PenBlu Software (http://www.penblu.com)
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  - Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *  - Neither the name of PenBlu Software nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * PenBlu is based on code by
 * Yii Software LLC (http://www.yiisoft.com) Copyright © 2008
 */

namespace app\controllers;

use Yii;
use app\components\CController;
use app\models\Usuario;
use app\models\Utilities;
use app\models\TipoPassword;

class PerfilController extends CController
{
    public function actionIndex()
    {
        return $this->render('index');
    }
    
    public function actionSave(){
        if (Yii::$app->request->isAjax) {
            $data = Yii::$app->request->post();
            try {
                $user = Usuario::findIdentity(Yii::$app->session->get("PB_iduser"));
                if($user){
                    // validar que clave cumpla con la regla de seguridad
                    $tpass = TipoPassword::findIdentity(1);// get Simple Password Type
                    $minPass = 8;
                    if(Yii::$app->session->get("PB_iduser") == 1){//admin
                        $tpass = TipoPassword::findIdentity(3);// get Simple Password Type
                    }
                    $regx = str_replace("VAR", $minPass, $tpass->tpas_validacion);
                    if(!preg_match($regx, $data["new"])){
                        $message = array( 
                            "wtmessage" => "La contraseña no cumple con el nivel de seguridad minimo 8 caracteres y de ".$tpass->tpas_descripcion,
                            "title"=> Yii::t('jslang', 'Error'),
                            );
                        echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                        return;
                    }
                    
                    // validar password
                    if($user->validatePassword($data["current"])){
                        // se guarda la nueva clave
                        $user->generateAuthKey();// generacion de hash
                        $user->setPassword($data["new"]);
                        $user->save();
                        $message = array( 
                            "wtmessage" => Yii::t("passreset","Change Password Successfull"),
                            "title"=> Yii::t('jslang', 'Success'),
                            );
                        echo Utilities::ajaxResponse('OK', 'alert', Yii::t('jslang', 'Success'), 'false', $message);
                        return;
                    }else{
                        $message = array( 
                            "wtmessage" => "La antigua contraseña no corresponde a su contraseña actual",
                            "title"=> Yii::t('jslang', 'Error'),
                            );
                        echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                        return;
                    }
                    
                }else{
                    $message = array( 
                        "wtmessage" => "Acceso no Permitido",
                        "title"=> Yii::t('jslang', 'Error'),
                        );
                    echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                    return;
                }
            } catch (Exception $ex) {
                $message = array( 
                        "wtmessage" => "Error Interno. Vuelva a intentar",
                        "title"=> Yii::t('jslang', 'Error'),
                        );
                    echo Utilities::ajaxResponse('NOOK', 'alert', Yii::t('jslang', 'Error'), 'true', $message);
                    return;
            }
        }
    }
}
