<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "parroquia".
 *
 * @property integer $par_id
 * @property integer $can_id
 * @property string $par_nombre
 * @property string $par_descripcion
 * @property string $par_estado_activo
 * @property string $par_fecha_creacion
 * @property string $par_fecha_modificacion
 * @property string $par_estado_logico
 *
 * @property Canton $can
 * @property Persona[] $personas
 */
class Parroquia extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'parroquia';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['can_id', 'par_estado_activo', 'par_estado_logico'], 'required'],
            [['can_id'], 'integer'],
            [['par_fecha_creacion', 'par_fecha_modificacion'], 'safe'],
            [['par_nombre', 'par_descripcion'], 'string', 'max' => 50],
            [['par_estado_activo', 'par_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'par_id' => Yii::t('parroquia', 'Par ID'),
            'can_id' => Yii::t('parroquia', 'Can ID'),
            'par_nombre' => Yii::t('parroquia', 'Par Nombre'),
            'par_descripcion' => Yii::t('parroquia', 'Par Descripcion'),
            'par_estado_activo' => Yii::t('parroquia', 'Par Estado Activo'),
            'par_fecha_creacion' => Yii::t('parroquia', 'Par Fecha Creacion'),
            'par_fecha_modificacion' => Yii::t('parroquia', 'Par Fecha Modificacion'),
            'par_estado_logico' => Yii::t('parroquia', 'Par Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCan()
    {
        return $this->hasOne(Canton::className(), ['can_id' => 'can_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPersonas()
    {
        return $this->hasMany(Persona::className(), ['par_id_nacimiento' => 'par_id']);
    }
    
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    public static function getParroquias(){
        return static::findAll(["par_estado_activo" => 1, "par_estado_logico" => 1]);
    }
    
    public static function getParroquiasByCanton($can_id){
        return static::findAll(["par_estado_activo" => 1, "par_estado_logico" => 1, "can_id" => $can_id]);
    }
    
    public static function getParroquiasByCantonID($canton_id){
        $sql = "SELECT par_id AS id, par_nombre AS name FROM parroquia WHERE can_id=:canton_id";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":canton_id", $canton_id, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
}
