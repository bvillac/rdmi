<?php

namespace app\models;

use Yii;
use yii\db\Expression;
use yii\behaviors\TimestampBehavior;
use yii\behaviors\AttributeBehavior;
use yii\db\ActiveRecord;
/**
 * This is the model class for table "mce_registro".
 *
 * @property integer $reg_id
 * @property integer $usu_id
 * @property integer $reg_estado
 * @property string $reg_fecha_creacion
 * @property string $reg_fecha_modificacion
 * @property integer $reg_estado_logico
 *
 * @property MceFormulario[] $mceFormularios
 * @property MceFormularioTemp[] $mceFormularioTemps
 * @property Usuario $usu
 */
class MceRegistro extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'mce_registro';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['usu_id'], 'required'],
            [['usu_id', 'reg_estado', 'reg_estado_logico'], 'integer'],
            [['reg_fecha_creacion', 'reg_fecha_modificacion'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'reg_id' => Yii::t('mce_registro', 'Reg ID'),
            'usu_id' => Yii::t('mce_registro', 'Usu ID'),
            'reg_estado' => Yii::t('mce_registro', 'Reg Estado'),
            'reg_fecha_creacion' => Yii::t('mce_registro', 'Reg Fecha Creacion'),
            'reg_fecha_modificacion' => Yii::t('mce_registro', 'Reg Fecha Modificacion'),
            'reg_estado_logico' => Yii::t('mce_registro', 'Reg Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMceFormularios()
    {
        return $this->hasMany(MceFormulario::className(), ['reg_id' => 'reg_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMceFormularioTemps()
    {
        return $this->hasMany(MceFormularioTemp::className(), ['reg_id' => 'reg_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsu()
    {
        return $this->hasOne(Usuario::className(), ['usu_id' => 'usu_id']);
    }
    
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    public static function findByCondition($condition) {
        return parent::findByCondition($condition);
    }
    
    public function behaviors() {
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['reg_fecha_creacion'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['reg_fecha_modificacion'],
                ],
                'value' => new Expression('NOW()'),
            ],
            'integer' => [
                'class' => AttributeBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['reg_estado','reg_estado_logico'],
                ],
                'value' => '1',
            ],
        ];
    }
}
