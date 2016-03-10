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
 * @property integer $per_id
 * @property string $per_nombres
 * @property string $per_apellidos
 * @property string $per_cedula
 * @property string $per_ruc
 * @property string $per_pasaporte
 * @property string $per_fecha_nacimiento
 * @property string $per_direccion
 * @property string $per_telefono
 * @property integer $pai_id
 * @property integer $prov_id
 * @property integer $can_id
 * @property string $per_celular
 * @property string $per_genero
 * @property string $per_estado_civil
 * @property string $per_correo
 * @property string $per_foto
 * @property string $per_estado_activo
 * @property string $per_fecha_creacion
 * @property string $per_fecha_modificacion
 * @property string $per_estado_logico
 *
 * @property Pais $pai
 * @property Provincia $prov
 * @property Canton $can
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
            [['per_estado_activo', 'per_estado_logico', 'per_fecha_nacimiento', 'per_fecha_creacion', 'per_fecha_modificacion'], 'safe'],
            [['pai_id', 'prov_id', 'can_id'], 'integer'],
            [['per_nombres', 'per_apellidos', 'per_correo', 'per_foto'], 'string', 'max' => 100],
            [['per_cedula', 'per_ruc', 'per_pasaporte'], 'string', 'max' => 20],
            [['per_direccion', 'per_genero'], 'string', 'max' => 45],
            [['per_telefono', 'per_celular'], 'string', 'max' => 50],
            [['per_estado_civil'], 'string', 'max' => 10],
            [['per_estado_activo', 'per_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'per_id' => Yii::t('persona', 'Per ID'),
            'per_nombres' => Yii::t('persona', 'Per Nombres'),
            'per_apellidos' => Yii::t('persona', 'Per Apellidos'),
            'per_cedula' => Yii::t('persona', 'Per Cedula'),
            'per_ruc' => Yii::t('persona', 'Per Ruc'),
            'per_pasaporte' => Yii::t('persona', 'Per Pasaporte'),
            'per_fecha_nacimiento' => Yii::t('persona', 'Per Fecha Nacimiento'),
            'per_direccion' => Yii::t('persona', 'Per Direccion'),
            'per_telefono' => Yii::t('persona', 'Per Telefono'),
            'pai_id' => Yii::t('persona', 'Pai ID'),
            'prov_id' => Yii::t('persona', 'Prov ID'),
            'can_id' => Yii::t('persona', 'Can ID'),
            'per_celular' => Yii::t('persona', 'Per Celular'),
            'per_genero' => Yii::t('persona', 'Per Genero'),
            'per_estado_civil' => Yii::t('persona', 'Per Estado Civil'),
            'per_correo' => Yii::t('persona', 'Per Correo'),
            'per_foto' => Yii::t('persona', 'Per Foto'),
            'per_estado_activo' => Yii::t('persona', 'Per Estado Activo'),
            'per_fecha_creacion' => Yii::t('persona', 'Per Fecha Creacion'),
            'per_fecha_modificacion' => Yii::t('persona', 'Per Fecha Modificacion'),
            'per_estado_logico' => Yii::t('persona', 'Per Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPai()
    {
        return $this->hasOne(Pais::className(), ['pai_id' => 'pai_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProv()
    {
        return $this->hasOne(Provincia::className(), ['prov_id' => 'prov_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCan()
    {
        return $this->hasOne(Canton::className(), ['can_id' => 'can_id']);
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
                    ActiveRecord::EVENT_BEFORE_INSERT => ['per_fecha_creacion'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['per_fecha_modificacion'],
                ],
                'value' => new Expression('NOW()'),
            ],
            'integer' => [
                'class' => AttributeBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['per_estado_logico','per_estado_activo'],
                ],
                'value' => '1',
            ],
        ];
    }
}
