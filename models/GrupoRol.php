<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\db\Expression;
use yii\behaviors\TimestampBehavior;
use yii\behaviors\AttributeBehavior;
/**
 * This is the model class for table "grupo_rol".
 *
 * @property integer $grol_id
 * @property integer $gru_id
 * @property integer $rol_id
 * @property integer $usu_id
 * @property string $grol_estado_activo
 * @property string $grol_fecha_creacion
 * @property string $grol_fecha_modificacion
 * @property string $grol_estado_logico
 *
 * @property GrupObmoGrupRol[] $grupObmoGrupRols
 * @property Grupo $gru
 * @property Rol $rol
 * @property Usuario $usu
 */
class GrupoRol extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'grupo_rol';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['gru_id', 'rol_id', 'usu_id'], 'required'],
            [['gru_id', 'rol_id', 'usu_id'], 'integer'],
            [['grol_fecha_creacion', 'grol_fecha_modificacion'], 'safe'],
            [['grol_estado_activo', 'grol_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'grol_id' => Yii::t('grupo_rol', 'Grol ID'),
            'gru_id' => Yii::t('grupo_rol', 'Gru ID'),
            'rol_id' => Yii::t('grupo_rol', 'Rol ID'),
            'usu_id' => Yii::t('grupo_rol', 'Usu ID'),
            'grol_estado_activo' => Yii::t('grupo_rol', 'Grol Estado Activo'),
            'grol_fecha_creacion' => Yii::t('grupo_rol', 'Grol Fecha Creacion'),
            'grol_fecha_modificacion' => Yii::t('grupo_rol', 'Grol Fecha Modificacion'),
            'grol_estado_logico' => Yii::t('grupo_rol', 'Grol Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGrupObmoGrupRols()
    {
        return $this->hasMany(GrupObmoGrupRol::className(), ['grol_id' => 'grol_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGru()
    {
        return $this->hasOne(Grupo::className(), ['gru_id' => 'gru_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRol()
    {
        return $this->hasOne(Rol::className(), ['rol_id' => 'rol_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsu()
    {
        return $this->hasOne(Usuario::className(), ['usu_id' => 'usu_id']);
    }

    public function behaviors() {
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['grol_fecha_creacion'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['grol_fecha_modificacion'],
                ],
                'value' => new Expression('NOW()'),
            ],
            'integer' => [
                'class' => AttributeBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['grol_estado_logico','grol_estado_activo'],
                ],
                'value' => '1',
            ],
        ];
    }
}
