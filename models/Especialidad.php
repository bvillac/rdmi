<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "especialidad".
 *
 * @property string $esp_id
 * @property string $esp_nombre
 * @property integer $esp_nivel
 * @property string $esp_est_log
 * @property string $esp_fec_cre
 * @property string $esp_fec_mod
 *
 * @property Consultorio[] $consultorios
 * @property EspecialidadMedico[] $especialidadMedicos
 */
class Especialidad extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'especialidad';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['esp_nivel'], 'integer'],
            [['esp_fec_cre', 'esp_fec_mod'], 'safe'],
            [['esp_nombre'], 'string', 'max' => 60],
            [['esp_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'esp_id' => 'Esp ID',
            'esp_nombre' => 'Esp Nombre',
            'esp_nivel' => 'Esp Nivel',
            'esp_est_log' => 'Esp Est Log',
            'esp_fec_cre' => 'Esp Fec Cre',
            'esp_fec_mod' => 'Esp Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getConsultorios()
    {
        return $this->hasMany(Consultorio::className(), ['esp_id' => 'esp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEspecialidadMedicos()
    {
        return $this->hasMany(EspecialidadMedico::className(), ['esp_id' => 'esp_id']);
    }
}
