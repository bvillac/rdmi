<?php

namespace app\models;

use Yii;
use yii\data\ArrayDataProvider;
use app\models\Persona;
use app\models\Especialidad;

/**
 * This is the model class for table "medico".
 *
 * @property string $med_id
 * @property string $per_id
 * @property string $med_colegiado
 * @property string $med_registro
 * @property string $med_est_log
 * @property string $med_fec_cre
 * @property string $med_fec_mod
 *
 * @property EspecialidadMedico[] $especialidadMedicos
 * @property Persona $per
 * @property MedicoEmpresa[] $medicoEmpresas
 * @property Resultados[] $resultados
 */
class Medico extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'medico';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['per_id'], 'required'],
            [['per_id'], 'integer'],
            [['med_fec_cre', 'med_fec_mod'], 'safe'],
            [['med_colegiado'], 'string', 'max' => 100],
            [['med_registro'], 'string', 'max' => 20],
            [['med_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'med_id' => 'Med ID',
            'per_id' => 'Per ID',
            'med_colegiado' => 'Med Colegiado',
            'med_registro' => 'Med Registro',
            'med_est_log' => 'Med Est Log',
            'med_fec_cre' => 'Med Fec Cre',
            'med_fec_mod' => 'Med Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEspecialidadMedicos()
    {
        return $this->hasMany(EspecialidadMedico::className(), ['med_id' => 'med_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPer()
    {
        return $this->hasOne(Persona::className(), ['per_id' => 'per_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMedicoEmpresas()
    {
        return $this->hasMany(MedicoEmpresa::className(), ['med_id' => 'med_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getResultados()
    {
        return $this->hasMany(Resultados::className(), ['med_id' => 'med_id']);
    }
    
    public static function consultarMedicos($data){
        $con = \Yii::$app->db;
        
        $sql = "SELECT a.med_id Ids,a.med_registro Registro,a.med_est_log Estado,CONCAT(b.per_nombre,' ',b.per_apellido) Nombres,d.emp_nombre Empresa
                    FROM " . $con->dbname . ".medico a
                      INNER JOIN " . $con->dbname . ".persona b
                          ON a.per_id=b.per_id
                      INNER JOIN (" . $con->dbname . ".medico_empresa c
                              LEFT JOIN " . $con->dbname . ".empresa d
                                ON c.emp_id=d.emp_id)
                          ON a.med_id=c.med_id
                  WHERE a.med_est_log=1 ";        
        $sql .= "ORDER BY b.per_nombre DESC ";
        
        //Utilities::putMessageLogFile($sql);
        $comando = $con->createCommand($sql);

        $resultData=$comando->queryAll();
        $dataProvider = new ArrayDataProvider([
            'key' => 'Ids',
            'allModels' => $resultData,
            'pagination' => [
                'pageSize' => Yii::$app->params["pageSize"],
            ],
            'sort' => [              
                'attributes' => ['Ids','Nombres','Registro','Empresa'],
            ],
        ]);

        return $dataProvider;
    }
    
    public function buscarMedicoID($ids){
        $con = \Yii::$app->db;   
        $sql = "SELECT med_id,per_id,med_colegiado,med_registro FROM " . $con->dbname . ".medico WHERE med_id=:med_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":med_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function getEspecilidades() {
        $con = \Yii::$app->db;
        $sql="SELECT esp_id,esp_nombre FROM " . $con->dbname . ".especialidad WHERE esp_est_log=1 ";
        $comando = $con->createCommand($sql);
        return $comando->queryAll();
    }
    
    public static function getEspecilidadesMedico($ids){
        $con = \Yii::$app->db;
        $sql="SELECT b.esp_id IdsEsp,b.esp_nombre Especialidad FROM " . $con->dbname . ".especialidad_medico a
                INNER JOIN " . $con->dbname . ".especialidad b
                  ON a.esp_id=b.esp_id
            WHERE a.med_id=:med_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":med_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }

    
    /* ACTUALIZAR DATOS */
    public function insertarMedicos($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();
            Persona::insertarDataPerfil($con, $data);
            $per_id=$con->getLastInsertID();//IDS de la Persona
            Persona::insertarDataPerfilDatoAdicional($con, $data, $per_id);
            $this->insertarDataMedico($con, $data, $per_id);
            $med_id=$con->getLastInsertID();
            Especialidad::insertarDataEspecialidad($con, $data[0]['especialidades'], $med_id);
            Empresa::insertarDataEmpresa($con, $data[0]['emp_id'], $med_id);     
            Utilities::insertarLogs($con, $med_id, 'medico', 'Insert -> Med_id');
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            //$arroout["ids"]= $ftem_id;
            $arroout["status"]= true;
            //$arroout["secuencial"]= $doc_numero;
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    
    /* ACTUALIZAR DATOS */
    public function actualizarMedicos($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();
            $med_id=$data[0]['med_id'];
            $this->updateDataMedico($con, $data, $med_id);
            Persona::actualizarDataPerfil($con,$data);
            Persona::actualizarDataAdicional($con,$data);
            Especialidad::deleteDataEspecialidad($con, $med_id);
            Especialidad::insertarDataEspecialidad($con, $data[0]['especialidades'], $med_id);
            Empresa::deleteDataEmpresa($con, $med_id);
            Empresa::insertarDataEmpresa($con, $data[0]['emp_id'], $med_id);  
            Utilities::insertarLogs($con, $med_id, 'medico', 'Update -> Med_id');
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            //$arroout["ids"]= $ftem_id;
            $arroout["status"]= true;
            //$arroout["secuencial"]= $doc_numero;
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    
    
    private function updateDataMedico($con, $data, $med_id) {
        //Datos Adicionales        
        $sql = "UPDATE " . $con->dbname . ".medico
            SET med_colegiado = :med_colegiado,med_registro = :med_registro,med_fec_mod = CURRENT_TIMESTAMP()
        WHERE med_id = :med_id; ";        
        $command = $con->createCommand($sql);
        $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT); //Id Comparacion
        $command->bindParam(":med_colegiado", $data[0]['med_colegiado'], \PDO::PARAM_STR);
        $command->bindParam(":med_registro", $data[0]['med_registro'], \PDO::PARAM_STR);
        $command->execute();
    }

    
    private function insertarDataMedico($con, $data, $per_id) {
        //Datos Adicionales
        $sql = "INSERT INTO " . $con->dbname . ".medico
            (per_id,med_colegiado,med_registro,med_est_log)VALUES
            (:per_id,:med_colegiado,:med_registro,1); ";
        $command = $con->createCommand($sql);
        $command->bindParam(":per_id", $per_id, \PDO::PARAM_INT); //Id Comparacion
        $command->bindParam(":med_colegiado", $data[0]['med_colegiado'], \PDO::PARAM_STR);
        $command->bindParam(":med_registro", $data[0]['med_registro'], \PDO::PARAM_STR);
        $command->execute();
    }
    
    
    
    
    
    public static function eliminarMedico($data) {
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $ids = isset($data['ids']) ? base64_decode($data['ids']) :NULL;
            $sql = "UPDATE " . $con->dbname . ".medico SET med_est_log=0 WHERE med_id=:med_id";
            $command = $con->createCommand($sql);
            $command->bindParam(":med_id", $ids, \PDO::PARAM_INT);
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
