<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "especialidad".
 *
 * @property string $esp_id
 * @property string $esp_nombre
 * @property integer $esp_nivel
 * @property string $esp_est_log
 * @property string $esp_fec_cre
 * @property string $esp_fec_mod
 *
 * @property Consultorio[] $consultorios
 * @property EspecialidadMedico[] $especialidadMedicos
 */
class Especialidad extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'especialidad';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['esp_nivel'], 'integer'],
            [['esp_fec_cre', 'esp_fec_mod'], 'safe'],
            [['esp_nombre'], 'string', 'max' => 60],
            [['esp_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'esp_id' => 'Esp ID',
            'esp_nombre' => 'Esp Nombre',
            'esp_nivel' => 'Esp Nivel',
            'esp_est_log' => 'Esp Est Log',
            'esp_fec_cre' => 'Esp Fec Cre',
            'esp_fec_mod' => 'Esp Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getConsultorios()
    {
        return $this->hasMany(Consultorio::className(), ['esp_id' => 'esp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEspecialidadMedicos()
    {
        return $this->hasMany(EspecialidadMedico::className(), ['esp_id' => 'esp_id']);
    }
    
    public static function insertarDataEspecialidad($con, $dts_especialidad,$med_id) {
        //Si tiene valores Inserta Datos
        for ($i = 0; $i < sizeof($dts_especialidad); $i++) {
            $sql = "INSERT INTO " . $con->dbname . ".especialidad_medico
                (esp_id,med_id,emed_nivel,emed_est_log)VALUES
                (:esp_id,:med_id,5,1)";
            $command = $con->createCommand($sql);
            $command->bindParam(":esp_id", $dts_especialidad[$i], \PDO::PARAM_INT);//ID pais
            $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT);//ID pais
            $command->execute();
        }
    }
    
    
    public static function deleteDataEspecialidad($con, $med_id) {
        //Si tiene valores Inserta Datos
        $sql = "DELETE FROM " . $con->dbname . ".especialidad_medico WHERE med_id=:med_id ";
        $command = $con->createCommand($sql);
        $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT); //ID pais
        $command->execute();
    }
    
    public static function getMedicoEspecialidad($Ids){
        $con = \Yii::$app->db;
        $sql = "SELECT C.med_id Ids,CONCAT(D.per_nombre,' ',D.per_apellido,' (',A.esp_nombre,')') Nombre
                    FROM " . $con->dbname . ".especialidad A
                            INNER JOIN (" . $con->dbname . ".especialidad_medico B
                                            INNER JOIN (" . $con->dbname . ".medico C
                                                            INNER JOIN " . $con->dbname . ".persona D
                                                                    ON C.per_id=D.per_id)
                                                    ON B.med_id=C.med_id)
                                    ON A.esp_id=B.esp_id
            WHERE A.esp_est_log=1 AND A.esp_id=:esp_id  ";
        
        $comando = $con->createCommand($sql);
        $comando->bindParam(":esp_id", $Ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function getMedicoEspeLine($Ids){
        $con = \Yii::$app->db;
        $Espec="";
        $sql = "SELECT N.esp_nombre Especialidad FROM " . $con->dbname . ".especialidad_medico M 
			INNER JOIN " . $con->dbname . ".especialidad N
				ON M.esp_id=N.esp_id
		WHERE M.med_id=:med_id ";  
        //Utilities::putMessageLogFile($sql.$Ids);
        $comando = $con->createCommand($sql);
        $comando->bindParam(":med_id", $Ids, \PDO::PARAM_INT);
        $result = $comando->queryAll();
        foreach($result as $key => $value){
            $Espec .=$value["Especialidad"].", ";
        }
        return $Espec;
    }
    
    public static function getEspecialidadALL(){
        $con = \Yii::$app->db;
        $Espec="";
        $sql = "SELECT esp_id Ids,esp_nombre Nombre FROM " . $con->dbname . ".especialidad WHERE esp_est_log=1 ";
        //Utilities::putMessageLogFile($sql.$Ids);
        $comando = $con->createCommand($sql);
        //$comando->bindParam(":med_id", $Ids, \PDO::PARAM_INT);
        return $comando->queryAll();
        
    }
    
    public static function getTipoConsulta(){
        $con = \Yii::$app->db;
        $Espec="";
        $sql = "SELECT tcon_id Ids,tcon_nombre Nombre FROM " . $con->dbname . ".tipo_consulta WHERE tcon_est_log=1 ";
        //Utilities::putMessageLogFile($sql.$Ids);
        $comando = $con->createCommand($sql);
        return $comando->queryAll();
        
    }
    
    
    

}
