<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "empresa".
 *
 * @property string $emp_id
 * @property string $emp_nombre
 * @property string $emp_ruc
 * @property string $emp_descripcion
 * @property string $emp_direccion
 * @property string $emp_telefono
 * @property string $emp_est_log
 * @property string $emp_fec_cre
 * @property string $emp_fec_mod
 *
 * @property CentroAtencion[] $centroAtencions
 * @property HorarioMedico[] $horarioMedicos
 * @property MedicoEmpresa[] $medicoEmpresas
 * @property UsuarioEmpresa[] $usuarioEmpresas
 */
class Empresa extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'empresa';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['emp_fec_cre', 'emp_fec_mod'], 'safe'],
            [['emp_nombre'], 'string', 'max' => 50],
            [['emp_ruc'], 'string', 'max' => 15],
            [['emp_descripcion', 'emp_direccion'], 'string', 'max' => 100],
            [['emp_telefono'], 'string', 'max' => 20],
            [['emp_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'emp_id' => 'Emp ID',
            'emp_nombre' => 'Emp Nombre',
            'emp_ruc' => 'Emp Ruc',
            'emp_descripcion' => 'Emp Descripcion',
            'emp_direccion' => 'Emp Direccion',
            'emp_telefono' => 'Emp Telefono',
            'emp_est_log' => 'Emp Est Log',
            'emp_fec_cre' => 'Emp Fec Cre',
            'emp_fec_mod' => 'Emp Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCentroAtencions()
    {
        return $this->hasMany(CentroAtencion::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHorarioMedicos()
    {
        return $this->hasMany(HorarioMedico::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMedicoEmpresas()
    {
        return $this->hasMany(MedicoEmpresa::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsuarioEmpresas()
    {
        return $this->hasMany(UsuarioEmpresa::className(), ['emp_id' => 'emp_id']);
    }
    
    public static function getEmpresas() {
        $con = \Yii::$app->db;
        $sql="SELECT emp_id,emp_nombre FROM " . $con->dbname . ".empresa WHERE emp_est_log=1 ;";
        $comando = $con->createCommand($sql);
        return $comando->queryAll();
    }
    
    public static function getEmpresaMedico($ids){
        $con = \Yii::$app->db;
        $sql="SELECT b.emp_id IdsEmp,b.emp_nombre Empresa FROM " . $con->dbname . ".medico_empresa a
                INNER JOIN " . $con->dbname . ".empresa b
                  ON a.emp_id=b.emp_id
            WHERE a.med_id=:med_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":med_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function insertarDataEmpresa($con, $emp_id,$med_id) {
        //Si tiene valores Inserta Datos
        $sql = "INSERT INTO " . $con->dbname . ".medico_empresa
            (med_id,emp_id,memp_est_log)VALUES(:med_id,:emp_id,1);";
            $command = $con->createCommand($sql);
            $command->bindParam(":emp_id", $emp_id, \PDO::PARAM_INT);//ID pais
            $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT);//ID pais
            $command->execute();
    }
    
    public static function deleteDataEmpresa($con, $med_id) {
        //Si tiene valores Inserta Datos
        $sql = "DELETE FROM " . $con->dbname . ".medico_empresa WHERE med_id=:med_id ";
        $command = $con->createCommand($sql);
        $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT); //ID pais
        $command->execute();
    }
    
    public static function getCentroMedicoEmp($ids){
        $con = \Yii::$app->db;
        $sql="SELECT cate_id Ids,cate_nombre Nombre FROM " . $con->dbname . ".centro_atencion WHERE emp_id=:emp_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":emp_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function getConsultorioMedicoEmp($data){
        $con = \Yii::$app->db;     
        $sql="SELECT cons_id Ids,cons_nombre Nombre FROM " . $con->dbname . ".consultorio WHERE esp_id=:esp_id AND cate_id=:cate_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":esp_id", $data['esp_id'], \PDO::PARAM_INT);
        $comando->bindParam(":cate_id", $data['cate_id'], \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    
}
