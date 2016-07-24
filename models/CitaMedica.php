<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "cita_medica".
 *
 * @property string $cmde_id
 * @property string $acit_id
 * @property string $pac_id
 * @property string $cprog_id
 * @property string $tcon_id
 * @property string $hora_id
 * @property string $fecha_id
 * @property string $cons_id
 * @property string $tur_id
 * @property integer $tur_numero
 * @property resource $cmde_motivo
 * @property resource $cmde_observacion
 * @property string $cmde_estado_asistencia
 * @property string $cmde_est_log
 * @property string $cmde_fec_cre
 * @property string $cmde_fec_mod
 *
 * @property TipoConsulta $tcon
 * @property AgendarCita $acit
 * @property Horario $hora
 * @property Turno $tur
 * @property SignosVitales[] $signosVitales
 */
class CitaMedica extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cita_medica';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['acit_id', 'pac_id', 'cprog_id', 'tcon_id', 'hora_id', 'fecha_id', 'cons_id', 'tur_id', 'tur_numero'], 'required'],
            [['acit_id', 'pac_id', 'cprog_id', 'tcon_id', 'cons_id', 'tur_id', 'tur_numero'], 'integer'],
            [['hora_id', 'fecha_id', 'cmde_fec_cre', 'cmde_fec_mod'], 'safe'],
            [['cmde_motivo', 'cmde_observacion'], 'string'],
            [['cmde_estado_asistencia', 'cmde_est_log'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'cmde_id' => 'Cmde ID',
            'acit_id' => 'Acit ID',
            'pac_id' => 'Pac ID',
            'cprog_id' => 'Cprog ID',
            'tcon_id' => 'Tcon ID',
            'hora_id' => 'Hora ID',
            'fecha_id' => 'Fecha ID',
            'cons_id' => 'Cons ID',
            'tur_id' => 'Tur ID',
            'tur_numero' => 'Tur Numero',
            'cmde_motivo' => 'Cmde Motivo',
            'cmde_observacion' => 'Cmde Observacion',
            'cmde_estado_asistencia' => 'Cmde Estado Asistencia',
            'cmde_est_log' => 'Cmde Est Log',
            'cmde_fec_cre' => 'Cmde Fec Cre',
            'cmde_fec_mod' => 'Cmde Fec Mod',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTcon()
    {
        return $this->hasOne(TipoConsulta::className(), ['tcon_id' => 'tcon_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAcit()
    {
        return $this->hasOne(AgendarCita::className(), ['acit_id' => 'acit_id', 'pac_id' => 'pac_id', 'cprog_id' => 'cprog_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getHora()
    {
        return $this->hasOne(Horario::className(), ['hora_id' => 'hora_id', 'fecha_id' => 'fecha_id', 'cons_id' => 'cons_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTur()
    {
        return $this->hasOne(Turno::className(), ['tur_id' => 'tur_id', 'tur_numero' => 'tur_numero']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSignosVitales()
    {
        return $this->hasMany(SignosVitales::className(), ['cmde_id' => 'cmde_id']);
    }
    

    
}
