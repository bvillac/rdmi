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
    
    public static function getTipoImagenesIds($ids){
        $con = \Yii::$app->db;        
        $sql="SELECT * FROM " . $con->dbname . ".tipo_dicom WHERE tdic_est_log=1 AND tdic_id=:tdic_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":tdic_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function insertarImagenes($data) {
        //Utilities::putMessageLogFile($data);
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();        
        try {
  
            $sql = "INSERT INTO " . $con->dbname . ".imagenes
                (pac_id,tdic_id,eve_id,ima_titulo,ima_nombre_archivo,ima_extension_archivo,
                ima_ruta_archivo,ima_observacion,ima_est_log)VALUES
                (:pac_id,:tdic_id,:eve_id,:ima_titulo,:ima_nombre_archivo,:ima_extension_archivo,
                :ima_ruta_archivo,:ima_observacion,1); ";

            $command = $con->createCommand($sql);
            $command->bindParam(":pac_id", $data['pac_id'], \PDO::PARAM_INT);
            $command->bindParam(":tdic_id", $data['tdic_id'], \PDO::PARAM_INT);
            $command->bindParam(":eve_id", $data['eve_id'], \PDO::PARAM_INT);
            $command->bindParam(":ima_titulo", $data['ima_titulo'], \PDO::PARAM_STR);
            $command->bindParam(":ima_nombre_archivo", $data['ima_nombre_archivo'], \PDO::PARAM_STR);
            $command->bindParam(":ima_extension_archivo", $data['ima_extension_archivo'], \PDO::PARAM_STR);
            $command->bindParam(":ima_ruta_archivo", $data['ima_ruta_archivo'], \PDO::PARAM_STR);
            $command->bindParam(":ima_observacion",$data['ima_observacion'], \PDO::PARAM_STR);
            //$command->bindParam(":ima_est_log", '1', \PDO::PARAM_STR);
            $command->execute();
            
            $trans->commit();
            $con->close();
            //$arroout["status"]= true;
            return true;
        } catch (Exception $ex) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            //$arroout["status"] = false;
            return false;//$arroout;
        }
    }

    
}
