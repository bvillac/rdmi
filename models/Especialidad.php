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
    
    public static function insertarDataEspecialidad($con, $dts_especialidad,$med_id) {
        //Si tiene valores Inserta Datos
        for ($i = 0; $i < sizeof($dts_especialidad); $i++) {
            $sql = "INSERT INTO " . $con->dbname . ".especialidad_medico
                (esp_id,med_id,emed_nivel,emed_est_log)VALUES
                (:esp_id,:med_id,5,1)";
            $command = $con->createCommand($sql);
            $command->bindParam(":esp_id", $dts_especialidad[$i], \PDO::PARAM_INT);//ID pais
            $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT);//ID pais
            $command->execute();
        }
    }
    
    
    public static function deleteDataEspecialidad($con, $med_id) {
        //Si tiene valores Inserta Datos
        $sql = "DELETE FROM " . $con->dbname . ".especialidad_medico WHERE med_id=:med_id ";
        $command = $con->createCommand($sql);
        $command->bindParam(":med_id", $med_id, \PDO::PARAM_INT); //ID pais
        $command->execute();
    }

}
