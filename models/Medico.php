<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "medico".
 *
 * @property string $med_id
 * @property string $per_id
 * @property string $med_colegiado
 * @property string $med_registro
 * @property string $med_est_log
 * @property string $med_fec_cre
 * @property string $med_fec_mod
 *
 * @property EspecialidadMedico[] $especialidadMedicos
 * @property Persona $per
 * @property MedicoEmpresa[] $medicoEmpresas
 */
class Medico extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'medico';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['per_id'], 'required'],
            [['per_id'], 'integer'],
            [['med_fec_cre', 'med_fec_mod'], 'safe'],
            [['med_colegiado'], 'string', 'max' => 100],
            [['med_registro'], 'string', 'max' => 20],
            [['med_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'med_id' => 'Med ID',
            'per_id' => 'Per ID',
            'med_colegiado' => 'Med Colegiado',
            'med_registro' => 'Med Registro',
            'med_est_log' => 'Med Est Log',
            'med_fec_cre' => 'Med Fec Cre',
            'med_fec_mod' => 'Med Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEspecialidadMedicos()
    {
        return $this->hasMany(EspecialidadMedico::className(), ['med_id' => 'med_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPer()
    {
        return $this->hasOne(Persona::className(), ['per_id' => 'per_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMedicoEmpresas()
    {
        return $this->hasMany(MedicoEmpresa::className(), ['med_id' => 'med_id']);
    }
}
