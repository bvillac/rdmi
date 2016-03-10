<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "provincia".
 *
 * @property integer $prov_id
 * @property integer $pai_id
 * @property string $prov_nombre
 * @property string $prov_descripcion
 * @property string $prov_estado_activo
 * @property string $prov_fecha_creacion
 * @property string $prov_fecha_modificacion
 * @property string $prov_estado_logico
 *
 * @property Canton[] $cantons
 * @property Persona[] $personas
 * @property Pais $pai
 */
class Provincia extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'provincia';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pai_id', 'prov_estado_activo', 'prov_estado_logico'], 'required'],
            [['pai_id'], 'integer'],
            [['prov_fecha_creacion', 'prov_fecha_modificacion'], 'safe'],
            [['prov_nombre', 'prov_descripcion'], 'string', 'max' => 100],
            [['prov_estado_activo', 'prov_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'prov_id' => Yii::t('provincia', 'Pro ID'),
            'pai_id' => Yii::t('provincia', 'Pai ID'),
            'prov_nombre' => Yii::t('provincia', 'Pro Nombre'),
            'prov_descripcion' => Yii::t('provincia', 'Pro Descripcion'),
            'prov_estado_activo' => Yii::t('provincia', 'Pro Estado Activo'),
            'prov_fecha_creacion' => Yii::t('provincia', 'Pro Fecha Creacion'),
            'prov_fecha_modificacion' => Yii::t('provincia', 'Pro Fecha Modificacion'),
            'prov_estado_logico' => Yii::t('provincia', 'Pro Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCantons()
    {
        return $this->hasMany(Canton::className(), ['prov_id' => 'prov_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPersonas()
    {
        return $this->hasMany(Persona::className(), ['prov_id' => 'prov_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPai()
    {
        return $this->hasOne(Pais::className(), ['pai_id' => 'pai_id']);
    }
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    public static function getProvincias(){
        return static::findAll(["prov_estado_activo" => 1, "prov_estado_logico" => 1]);
    }
    
    public static function getProvinciasByPais($pais_id){
        return static::findAll(["prov_estado_activo" => 1, "prov_estado_logico" => 1, "pai_id" => $pais_id]);
    }
    
    public static function getProvinciasByPaisID($pais_id){
        $sql = "SELECT prov_id AS id, prov_nombre AS name FROM provincia WHERE pai_id=:pais_id";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":pais_id", $pais_id, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function getPaisID($prov_id) {
        $sql = "SELECT pai_id FROM " . Yii::$app->db->dbname . ".provincia WHERE prov_id=:prov_id AND prov_estado_logico=1";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":prov_id", $prov_id, \PDO::PARAM_INT);
        $rawData=$comando->queryScalar();
        if ($rawData === false)
            return 0; //en caso de que existe problema o no retorne nada tiene 1 por defecto 
        return $rawData;
    }
    
    public static function getNivelDistribucion($ids,$op){
        $con = \Yii::$app->db;
        switch ($op) {
                case '1'://Nivel Internacional
                    $sql="SELECT A.mlte_id,A.pai_id,B.pai_nombre Pais
                            FROM " . $con->dbname . ".mce_marca_lugar_temp A
                              INNER JOIN " . $con->dbname . ".pais B
                                ON A.pai_id=B.pai_id
                          WHERE A.mlte_estado_logico=1 AND A.ftem_id=:ftem_id AND A.prov_id is null ";
                    break;
                case '2'://Nivel Nacional
                    $sql="SELECT A.mlte_id,A.prov_id,C.prov_nombre Provincia
                                FROM mce_base.mce_marca_lugar_temp A
                                  INNER JOIN mce_base.provincia C
                                          ON A.prov_id=C.prov_id
                              WHERE A.mlte_estado_logico=1 AND A.ftem_id=:ftem_id AND A.prov_id is not null ";
                    break;
                default:
            }
        $comando = $con->createCommand($sql);
        $comando->bindParam(":ftem_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }

}
