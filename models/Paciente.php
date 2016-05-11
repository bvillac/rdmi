<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "paciente".
 *
 * @property string $pac_id
 * @property string $per_id
 * @property string $pac_fecha_ingreso
 * @property string $pac_est_log
 * @property string $pac_fec_cre
 * @property string $pac_fec_mod
 *
 * @property CitaProgramada[] $citaProgramadas
 * @property Persona $per
 */
class Paciente extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'paciente';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['per_id'], 'required'],
            [['per_id'], 'integer'],
            [['pac_fecha_ingreso', 'pac_fec_cre', 'pac_fec_mod'], 'safe'],
            [['pac_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'pac_id' => 'Pac ID',
            'per_id' => 'Per ID',
            'pac_fecha_ingreso' => 'Pac Fecha Ingreso',
            'pac_est_log' => 'Pac Est Log',
            'pac_fec_cre' => 'Pac Fec Cre',
            'pac_fec_mod' => 'Pac Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCitaProgramadas()
    {
        return $this->hasMany(CitaProgramada::className(), ['pac_id' => 'pac_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPer()
    {
        return $this->hasOne(Persona::className(), ['per_id' => 'per_id']);
    }
}
