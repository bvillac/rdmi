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
    
    public function insertarImagenes($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        
        try {
  
            $sql = "INSERT INTO " . $con->dbname . ".imagenes
                (pac_id,tdic_id,eve_id,ima_titulo,ima_nombre_archivo,ima_extension_archivo,
                ima_ruta_archivo,ima_observacion,ima_fecha_publica,ima_est_log)VALUES
                (:pac_id,:tdic_id,:eve_id,:ima_titulo,:ima_nombre_archivo,:ima_extension_archivo,
                :ima_ruta_archivo,:ima_observacion,:ima_fecha_publica,:ima_est_log); ";

            $command = $con->createCommand($sql);
            $command->bindParam(":pac_id", $data[0]['per_id'], \PDO::PARAM_INT);//Id Comparacion
            $command->bindParam(":per_nombre", $data[0]['per_nombre'], \PDO::PARAM_STR);
            $command->bindParam(":per_apellido", $data[0]['per_apellido'], \PDO::PARAM_STR);
            $command->bindParam(":per_ced_ruc", $data[0]['per_ced_ruc'], \PDO::PARAM_STR);
            $command->bindParam(":per_genero", $data[0]['per_genero'], \PDO::PARAM_STR);
            $command->bindParam(":per_fecha_nacimiento", $data[0]['per_fecha_nacimiento'], \PDO::PARAM_STR);
            $command->bindParam(":per_estado_civil", $data[0]['per_estado_civil'], \PDO::PARAM_STR);
            $command->bindParam(":per_correo", $data[0]['per_correo'], \PDO::PARAM_STR);
            $command->bindParam(":per_tipo_sangre", $data[0]['per_tipo_sangre'], \PDO::PARAM_STR);
            $command->bindParam(":per_foto", $data[0]['per_foto'], \PDO::PARAM_STR);
            $command->execute();
            
            //Utilities::insertarLogs($con, $med_id, 'medico', 'Insert -> Med_id');
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            //$arroout["ids"]= $ftem_id;
            $arroout["status"]= true;
            
        } catch (Exception $ex) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"] = false;
            return $arroout;
        }
    }

    
}
