<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\db\Expression;
use yii\data\ArrayDataProvider;
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
    
    /* ACTUALIZAR DATOS */
    public function actualizarPerfilPersona($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();    
            //$reg_id= Yii::$app->session->get('PB_idregister', FALSE);
            $this->actualizarDataPerfil($con,$data); 
            //$ftem_id=$data_1[0]['ftem_id'];//$con->getLastInsertID();//IDS Formulario Temp
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
    
    public function insertarDataPerfil($con,$data) {
        
        $sql = "INSERT INTO " . $con->dbname . ".persona
        (per_id,per_ced_ruc,per_nombre,per_apellido,per_genero,per_fecha_nacimiento,per_estado_civil,per_correo,
            per_factor_rh,per_tipo_sangre,per_foto,per_estado_activo,per_est_log,per_fec_cre,per_fec_mod)VALUES
        (:per_id,:per_ced_ruc,:per_nombre,:per_apellido,:per_genero,:per_fecha_nacimiento,:per_estado_civil,:per_correo,
         :per_factor_rh,:per_tipo_sangre,:per_foto,:per_estado_activo,:per_est_log,:per_fec_cre,:per_fec_mod ); ";

        $command = $con->createCommand($sql);
        $command->bindParam(":per_id", $data[0]['per_id'], \PDO::PARAM_INT);//Id Comparacion
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

        
        
        
    }
    
    private function actualizarDataPerfil($con,$data) {
        $sql = "UPDATE " . $con->dbname . ".persona
            SET per_ced_ruc = :per_ced_ruc,per_nombre = :per_nombre,per_apellido = :per_apellido,
            per_genero = :per_genero,per_fecha_nacimiento = :per_fecha_nacimiento,per_estado_civil = :per_estado_civil,
            per_correo = :per_correo,per_tipo_sangre = :per_tipo_sangre,per_foto = :per_foto,per_fec_mod = CURRENT_TIMESTAMP()
            WHERE per_id=:per_id ";
        $command = $con->createCommand($sql);
        $command->bindParam(":per_id", $data[0]['per_id'], \PDO::PARAM_INT);//Id Comparacion
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
        //Verificamos SI existe los Datos Adicionales
        $dper_id=$this->existeDatAdi($con, $data[0]['per_id']);
        if($dper_id>0){
            //Existe y Hay que Actualizar
            $sql = "UPDATE " . $con->dbname . ".data_persona
                SET per_id = :per_id,pai_id = :pai_id,prov_id = :prov_id,can_id = :can_id,dper_direccion = :dper_direccion,
                dper_telefono = :dper_telefono,dper_celular = :dper_celular,dper_contacto = :dper_contacto,dper_est_log = 1,
                dper_fec_mod=CURRENT_TIMESTAMP() WHERE dper_id=$dper_id "; 
        }else{
            //No Existe y Hay que Insertar
            $sql = "INSERT INTO " . $con->dbname . ".data_persona
                (per_id,pai_id,prov_id,can_id,dper_direccion,dper_telefono,dper_celular,dper_contacto,dper_est_log)VALUES
                (:per_id,:pai_id,:prov_id,:can_id,:dper_direccion,:dper_telefono,:dper_celular,:dper_contacto,1);";
        }
        $command = $con->createCommand($sql);
        $command->bindParam(":per_id", $data[0]['per_id'], \PDO::PARAM_INT);//Id Comparacion
        $command->bindParam(":pai_id", $data[0]['pai_id'], \PDO::PARAM_INT);
        $command->bindParam(":prov_id", $data[0]['prov_id'], \PDO::PARAM_INT);
        $command->bindParam(":can_id", $data[0]['can_id'], \PDO::PARAM_INT);
        $command->bindParam(":dper_direccion", $data[0]['dper_direccion'], \PDO::PARAM_STR);
        $command->bindParam(":dper_contacto", $data[0]['dper_contacto'], \PDO::PARAM_STR);
        $command->bindParam(":dper_telefono", $data[0]['dper_telefono'], \PDO::PARAM_STR);
        $command->bindParam(":dper_celular", $data[0]['dper_celular'], \PDO::PARAM_STR);
        $command->execute();

    }
    
    private function existeDatAdi($con,$ids){
        $sql = "SELECT dper_id FROM " . $con->dbname . ".data_persona WHERE per_id=:per_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":per_id", $ids, \PDO::PARAM_INT);
        $rawData=$comando->queryScalar();
        if ($rawData === false)
            return 0; //en caso de que existe problema o no retorne nada tiene 1 por defecto 
        return $rawData;
    }
    
    
}
