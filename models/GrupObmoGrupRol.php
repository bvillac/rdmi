<?php

namespace app\models;

use Yii;
use yii\db\ActiveRecord;
use yii\db\Expression;
use yii\behaviors\TimestampBehavior;
use yii\behaviors\AttributeBehavior;

/**
 * This is the model class for table "grup_obmo_grup_rol".
 *
 * @property integer $gogr_id
 * @property integer $grol_id
 * @property integer $gmod_id
 * @property string $gogr_estado_activo
 * @property string $gogr_fecha_creacion
 * @property string $gogr_fecha_modificacion
 * @property string $gogr_estado_logico
 *
 * @property GrupoRol $grol
 * @property GrupObmo $gmod
 */
class GrupObmoGrupRol extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'grup_obmo_grup_rol';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['grol_id', 'gmod_id'], 'required'],
            [['grol_id', 'gmod_id'], 'integer'],
            [['gogr_fecha_creacion', 'gogr_fecha_modificacion'], 'safe'],
            [['gogr_estado_activo', 'gogr_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'gogr_id' => Yii::t('grup_obmo_grup_rol', 'Gogr ID'),
            'grol_id' => Yii::t('grup_obmo_grup_rol', 'Grol ID'),
            'gmod_id' => Yii::t('grup_obmo_grup_rol', 'Gmod ID'),
            'gogr_estado_activo' => Yii::t('grup_obmo_grup_rol', 'Gogr Estado Activo'),
            'gogr_fecha_creacion' => Yii::t('grup_obmo_grup_rol', 'Gogr Fecha Creacion'),
            'gogr_fecha_modificacion' => Yii::t('grup_obmo_grup_rol', 'Gogr Fecha Modificacion'),
            'gogr_estado_logico' => Yii::t('grup_obmo_grup_rol', 'Gogr Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGrol()
    {
        return $this->hasOne(GrupoRol::className(), ['grol_id' => 'grol_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGmod()
    {
        return $this->hasOne(GrupObmo::className(), ['gmod_id' => 'gmod_id']);
    }
    
    public function behaviors() {
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['gogr_fecha_creacion'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['gogr_fecha_modificacion'],
                ],
                'value' => new Expression('NOW()'),
            ],
            'integer' => [
                'class' => AttributeBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['gogr_estado_logico','gogr_estado_activo'],
                ],
                'value' => '1',
            ],
        ];
    }
}
