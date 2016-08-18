<?php

namespace app\models;
use Yii;
use yii\data\ArrayDataProvider;
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
    
    /*CONSULTAR CITA PROGRAMADA*/
    public static function consultarCitasProg($data){
        $con = \Yii::$app->db;        
        $sql = "SELECT A.cprog_id Ids,C.per_ced_ruc Cedula,CONCAT(C.per_nombre,' ',C.per_apellido) Nombres,
                        A.cprog_observacion Observacion,E.esp_nombre Especialidad,A.cprog_est_log Estado
                    FROM " . $con->dbname . ".cita_programada A
                            INNER JOIN (" . $con->dbname . ".paciente B 
                                            INNER JOIN " . $con->dbname . ".persona C
                                                    ON B.per_id=C.per_id)
                                    ON B.pac_id=A.pac_id
                            INNER JOIN (" . $con->dbname . ".especialidad_medico D
                                            INNER JOIN " . $con->dbname . ".especialidad E
                                                    ON D.esp_id=E.esp_id)
                                    ON A.emed_id=D.emed_id
                    WHERE  ";
                    $sql .= ($data['estado'] > -1) ? " A.cprog_est_log = :cprog_est_log  " : " A.cprog_est_log<>0 ";
                    $sql .= "ORDER BY A.cprog_id DESC ";
        $comando = $con->createCommand($sql);
        
        if($data['estado'] > -1){
            $comando->bindParam(":cprog_est_log", $data['estado'], \PDO::PARAM_STR);
        }

        $resultData=$comando->queryAll();
        $dataProvider = new ArrayDataProvider([
            'key' => 'Ids',
            'allModels' => $resultData,
            'pagination' => [
                'pageSize' => Yii::$app->params["pageSize"],
            ],
            'sort' => [              
                'attributes' => ['Ids','Cedula','Nombres','Especialidad','Observacion','Estado'],
            ],
        ]);
        return $dataProvider;
    }
    
    /* INSERTAR DATOS */
    public function insertarCitasMedicas($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $observ = isset($data['OBSERV']) ? $data['OBSERV'] : "";
            $pac_id = isset($data['PAC_ID']) ? $data['PAC_ID'] : 0;
            $emed_id = isset($data['EMED_ID']) ? $data['EMED_ID'] : 0;

            $sql = "INSERT INTO " . $con->dbname . ".cita_programada
                (pac_id,emed_id,cprog_numero,cprog_observacion,cprog_est_log)VALUES
                (:pac_id,:emed_id,0,:cprog_observacion,1);";
            
            $command = $con->createCommand($sql);
            $command->bindParam(":pac_id", $pac_id, \PDO::PARAM_INT); 
            $command->bindParam(":emed_id", $emed_id, \PDO::PARAM_INT);
            $command->bindParam(":cprog_observacion", $observ, \PDO::PARAM_STR);
            $command->execute();
            $ids=$con->getLastInsertID();
            Utilities::insertarLogs($con, $ids, 'cita_programada', 'Insert -> cprog_id->'.$ids);
            
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            //$arroout["ids"]= $ftem_id;
            $arroout["status"]= true;
            //$arroout["secuencial"]= $doc_numero;
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    /*
     * RECHAZAR O CANCELAR LAS CITAS PROGRAMADAS
     */
    
    public static function rechazarCitaProgramada($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $ids = isset($data['ids']) ? base64_decode($data['ids']) :NULL;
            $sql = "UPDATE " . $con->dbname . ".cita_programada SET cprog_est_log=2 WHERE cprog_id=:cprog_id";
            $command = $con->createCommand($sql);
            $command->bindParam(":cprog_id", $ids, \PDO::PARAM_INT);
            $command->execute();
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            //$arroout["ids"]= $ftem_id;
            $arroout["status"]= true;
            //$arroout["secuencial"]= $doc_numero;
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    
    
}
