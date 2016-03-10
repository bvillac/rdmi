<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "pais".
 *
 * @property integer $pai_id
 * @property string $pai_nombre
 * @property string $pai_descripcion
 * @property string $pai_estado_activo
 * @property string $pai_fecha_creacion
 * @property string $pai_fecha_modificacion
 * @property string $pai_estado_logico
 *
 * @property Persona[] $personas
 * @property Provincia[] $provincias
 */
class Pais extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pais';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pai_estado_activo', 'pai_estado_logico'], 'required'],
            [['pai_fecha_creacion', 'pai_fecha_modificacion'], 'safe'],
            [['pai_nombre', 'pai_descripcion'], 'string', 'max' => 50],
            [['pai_estado_activo', 'pai_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'pai_id' => Yii::t('pais', 'Pai ID'),
            'pai_nombre' => Yii::t('pais', 'Pai Nombre'),
            'pai_descripcion' => Yii::t('pais', 'Pai Descripcion'),
            'pai_estado_activo' => Yii::t('pais', 'Pai Estado Activo'),
            'pai_fecha_creacion' => Yii::t('pais', 'Pai Fecha Creacion'),
            'pai_fecha_modificacion' => Yii::t('pais', 'Pai Fecha Modificacion'),
            'pai_estado_logico' => Yii::t('pais', 'Pai Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPersonas()
    {
        return $this->hasMany(Persona::className(), ['pai_id_nacimiento' => 'pai_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProvincias()
    {
        return $this->hasMany(Provincia::className(), ['pai_id' => 'pai_id']);
    }
    
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    public static function getPaises(){
        return static::findAll(["pai_estado_activo" => 1, "pai_estado_logico" => 1]);
    }
}
