<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\db\Expression;
use yii\behaviors\TimestampBehavior;
use yii\behaviors\AttributeBehavior;

/**
 * This is the model class for table "persona".
 *
 * @property string $per_id
 * @property string $per_ced_ruc
 * @property string $per_nombre
 * @property string $per_apellido
 * @property string $per_genero
 * @property string $per_fecha_nacimiento
 * @property string $per_estado_civil
 * @property string $per_correo
 * @property string $per_factor_rh
 * @property string $per_tipo_sangre
 * @property string $per_foto
 * @property string $per_estado_activo
 * @property string $per_est_log
 * @property string $per_fec_cre
 * @property string $per_fec_mod
 *
 * @property DataPersona[] $dataPersonas
 * @property Medico[] $medicos
 * @property Paciente[] $pacientes
 * @property Usuario[] $usuarios
 */
class Persona extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'persona';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['per_fecha_nacimiento', 'per_fec_cre', 'per_fec_mod'], 'safe'],
            [['per_estado_activo'], 'required'],
            [['per_ced_ruc'], 'string', 'max' => 15],
            [['per_nombre', 'per_apellido', 'per_correo', 'per_foto'], 'string', 'max' => 100],
            [['per_genero', 'per_estado_activo', 'per_est_log'], 'string', 'max' => 1],
            [['per_estado_civil'], 'string', 'max' => 2],
            [['per_factor_rh', 'per_tipo_sangre'], 'string', 'max' => 5]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'per_id' => Yii::t('persona', 'Per ID'),
            'per_ced_ruc' => Yii::t('persona', 'Per Cedula'),
            'per_nombre' => Yii::t('persona', 'Per Nombres'),
            'per_apellido' => Yii::t('persona', 'Per Apellidos'),
            'per_genero' => Yii::t('persona', 'Per Genero'),
            'per_fecha_nacimiento' =>  Yii::t('persona', 'Per Fecha Nacimiento'),
            'per_estado_civil' => Yii::t('persona', 'Per Estado Civil'),
            'per_correo' => Yii::t('persona', 'Per Correo'),
            'per_factor_rh' => 'Per Factor Rh',
            'per_tipo_sangre' => 'Per Tipo Sangre',
            'per_foto' => Yii::t('persona', 'Per Foto'),
            'per_estado_activo' => Yii::t('persona', 'Per Estado Activo'),
            'per_est_log' => Yii::t('persona', 'Per Estado Logico'),
            'per_fec_cre' => Yii::t('persona', 'Per Fecha Creacion'),
            'per_fec_mod' => Yii::t('persona', 'Per Fecha Modificacion'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDataPersonas()
    {
        return $this->hasMany(DataPersona::className(), ['per_id' => 'per_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMedicos()
    {
        return $this->hasMany(Medico::className(), ['per_id' => 'per_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPacientes()
    {
        return $this->hasMany(Paciente::className(), ['per_id' => 'per_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsuarios()
    {
        return $this->hasMany(Usuario::className(), ['per_id' => 'per_id']);
    }
    
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    public function behaviors() {
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['per_fec_cre'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['per_fec_mod'],
                ],
                'value' => new Expression('NOW()'),
            ],
            'integer' => [
                'class' => AttributeBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['per_est_log','per_estado_activo'],
                ],
                'value' => '1',
            ],
        ];
    }
    
    public function guardarPersonaRegistro(&$data) {
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $this->insertarPersonaRegistro($con, $data);
            $per_id = $con->getLastInsertID(); //IDS Formulario 
            $data->per_id=$per_id;
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
    
    private function insertarPersonaRegistro($con,$data) {
        $sql = "INSERT INTO " . $con->dbname . ".persona
            (per_nombre,per_apellido,per_correo,per_estado_activo,per_est_log)VALUES
            (:per_nombre,:per_apellido,:per_correo,1,1) ";
        $command = $con->createCommand($sql);
        $command->bindParam(":per_nombre",$data->per_nombre, \PDO::PARAM_STR);
        $command->bindParam(":per_apellido",$data->per_apellido, \PDO::PARAM_STR);
        $command->bindParam(":per_correo",$data->per_correo, \PDO::PARAM_STR);        
        $command->execute();
    }
    
    public function buscarPersonaID($ids){
        $con = \Yii::$app->db;        
        $sql = "SELECT A.per_id Ids,A.per_ced_ruc Cedula,A.per_nombre Nombre,A.per_apellido Apellido,A.per_genero Genero,A.per_fecha_nacimiento Fec_Nac,
            A.per_estado_civil Est_Civ,A.per_correo Correo,A.per_tipo_sangre Gru_San,A.per_foto Foto,A.per_estado_activo,
            A.per_est_log,A.per_fec_cre,B.pai_id Pais,B.prov_id Provincia,B.can_id Canton,B.dper_direccion Direccion,
            B.dper_telefono Telefono,B.dper_celular Celular,B.dper_contacto Contacto
              FROM " . $con->dbname . ".persona A
            LEFT JOIN " . $con->dbname . ".data_persona B ON A.per_id=B.per_id
        WHERE A.per_est_log=1 AND A.per_id=:per_id  ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":per_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
}
