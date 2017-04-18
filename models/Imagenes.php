<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

/**
 * Description of Imagenes
 *
 * @author root
 */
use yii;

class Imagenes {
    //put your code here
    
    public static function getTipoImagenesAll(){
        $con = \Yii::$app->db;        
        $sql="SELECT tdic_id Ids,concat(tdic_detalle,' (',tdic_nomenclatura,')') Nombre 
                FROM " . $con->dbname . ".tipo_dicom WHERE tdic_est_log=1;";
        $comando = $con->createCommand($sql);
        //$comando->bindParam(":med_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }

    
}
