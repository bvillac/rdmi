<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "empresa".
 *
 * @property string $emp_id
 * @property string $emp_nombre
 * @property string $emp_ruc
 * @property string $emp_descripcion
 * @property string $emp_direccion
 * @property string $emp_telefono
 * @property string $emp_est_log
 * @property string $emp_fec_cre
 * @property string $emp_fec_mod
 *
 * @property CentroAtencion[] $centroAtencions
 * @property HorarioMedico[] $horarioMedicos
 * @property MedicoEmpresa[] $medicoEmpresas
 * @property UsuarioEmpresa[] $usuarioEmpresas
 */
class Empresa extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'empresa';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['emp_fec_cre', 'emp_fec_mod'], 'safe'],
            [['emp_nombre'], 'string', 'max' => 50],
            [['emp_ruc'], 'string', 'max' => 15],
            [['emp_descripcion', 'emp_direccion'], 'string', 'max' => 100],
            [['emp_telefono'], 'string', 'max' => 20],
            [['emp_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'emp_id' => 'Emp ID',
            'emp_nombre' => 'Emp Nombre',
            'emp_ruc' => 'Emp Ruc',
            'emp_descripcion' => 'Emp Descripcion',
            'emp_direccion' => 'Emp Direccion',
            'emp_telefono' => 'Emp Telefono',
            'emp_est_log' => 'Emp Est Log',
            'emp_fec_cre' => 'Emp Fec Cre',
            'emp_fec_mod' => 'Emp Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCentroAtencions()
    {
        return $this->hasMany(CentroAtencion::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHorarioMedicos()
    {
        return $this->hasMany(HorarioMedico::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMedicoEmpresas()
    {
        return $this->hasMany(MedicoEmpresa::className(), ['emp_id' => 'emp_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUsuarioEmpresas()
    {
        return $this->hasMany(UsuarioEmpresa::className(), ['emp_id' => 'emp_id']);
    }
}
