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
use yii\data\ArrayDataProvider;

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
    
    
    
     /*CONSULTAR CITA PROGRAMADA*/
    public static function consultarFileall($data){
        $con = \Yii::$app->db;
        //$sqlMedico="";
        //Verifico si el Rol es de Medico
//        if(Yii::$app->session->get('RolId', FALSE)==3){ //Agrega Sentencia Sql
//            $MedId=Yii::$app->session->get('MedId', FALSE);
//            $sqlMedico="INNER JOIN " . $con->dbname . ".medico_atencion F
//                            ON F.pac_id=B.pac_id AND F.mate_est_log=1 AND F.med_id=$MedId ";
//        }
        $pac_id=1;
        $sql = "SELECT ima_id Ids,tdic_id Tipo,ima_titulo Titulo,ima_nombre_archivo File,ima_ruta_archivo Ruta,ima_fec_cre Fecha
                    FROM " . $con->dbname . ".imagenes WHERE ima_est_log=1  ";
        if($pac_id<>''){ $sql .= "AND pac_id=:pac_id ";}
        $sql .= "ORDER BY ima_id DESC ";
        
        $comando = $con->createCommand($sql);
        if($pac_id<>''){$comando->bindParam(":pac_id",$pac_id, \PDO::PARAM_STR); }
        
        //Utilities::putMessageLogFile($sql);
        

        $resultData=$comando->queryAll();
        $dataProvider = new ArrayDataProvider([
            'key' => 'Ids',
            'allModels' => $resultData,
            'pagination' => [
                'pageSize' => Yii::$app->params["pageSize"],
            ],
            'sort' => [              
                'attributes' => ['Ids','Tipo','Titulo','File','Ruta','Fecha'],
            ],
        ]);

        return $dataProvider;
    }
    
    public static function getImagenesIds($ids){
        $con = \Yii::$app->db;        
        $sql="SELECT * FROM " . $con->dbname . ".imagenes WHERE ima_id=:ima_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":ima_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function eliminarFile($ids) {
        //Utilities::putMessageLogFile($ids);
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $sql = "UPDATE " . $con->dbname . ".imagenes SET ima_est_log=0 WHERE ima_id=:ima_id";
            $command = $con->createCommand($sql);
            $command->bindParam(":ima_id", $ids, \PDO::PARAM_INT);
            $command->execute();
            $trans->commit();
            $con->close();
            return true;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            return false;
        }
    }
    
    

    
}
