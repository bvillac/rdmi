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
        $sqlMedico="";
        //Verifico si el Rol es de Medico
        if(Yii::$app->session->get('RolId', FALSE)==3){ //Agrega Sentencia Sql
            $MedId=Yii::$app->session->get('MedId', FALSE);
            $sqlMedico="INNER JOIN " . $con->dbname . ".medico_atencion F
                            ON F.pac_id=B.pac_id AND F.mate_est_log=1 AND F.med_id=$MedId ";
        }  
        $sql = "SELECT A.cprog_id Ids,C.per_ced_ruc Cedula,CONCAT(C.per_nombre,' ',C.per_apellido) Nombres,
                        A.cprog_observacion Observacion,E.esp_nombre Especialidad,A.cprog_est_log Estado
                    FROM " . $con->dbname . ".cita_programada A
                            INNER JOIN (" . $con->dbname . ".paciente B 
                                            INNER JOIN " . $con->dbname . ".persona C
                                                    ON B.per_id=C.per_id
                                            $sqlMedico )
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
    
    public static function existeCitaMedica($data){
        $con = \Yii::$app->db; 
        $pac_id = isset($data['PAC_ID']) ? $data['PAC_ID'] : 0;
        $emed_id = isset($data['EMED_ID']) ? $data['EMED_ID'] : 0;
        
        $sql = "SELECT cprog_id FROM " . $con->dbname . ".cita_programada 
            WHERE pac_id=:pac_id AND emed_id=:emed_id AND cprog_est_log NOT IN(0,2) ;";
        //AND DATE(cprog_fec_cre)='2016-08-16'

        $comando = $con->createCommand($sql);
        $comando->bindParam(":pac_id", $pac_id, \PDO::PARAM_INT);
        $comando->bindParam(":emed_id", $emed_id, \PDO::PARAM_INT);
        $rawData=$comando->queryScalar();
        if ($rawData === false)
            return 0; //en caso de que existe problema o no retorne nada tiene 1 por defecto 
        return $rawData;
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
    
    
    public static function getCentoAtencionEspecialidad($Ids){
        $con = \Yii::$app->db;
        $sql = "SELECT A.cons_id Ids, CONCAT(C.can_nombre,'-',B.cate_nombre) Nombre
                FROM " . $con->dbname . ".consultorio A
                        INNER JOIN (" . $con->dbname . ".centro_atencion B
                                        INNER JOIN " . $con->dbname . ".canton C
                                                ON C.can_id=B.can_id)
                                ON A.cate_id=B.cate_id
        WHERE A.cons_est_log=1 AND A.esp_id=:esp_id;";
        
        //Utilities::putMessageLogFile($sql.$Ids);
        $comando = $con->createCommand($sql);
        $comando->bindParam(":esp_id", $Ids, \PDO::PARAM_INT);
        return $comando->queryAll();
        
    }
    
    public static function getHorarioAtencion($Ids,$Fecha){
        $con = \Yii::$app->db;               
        $sql = "SELECT A.hora_id Ids,CONCAT(A.hora_inicio,'- Dr(a) ',C.per_nombre,' ',C.per_apellido) Nombre
                FROM " . $con->dbname . ".horario A
                        INNER JOIN (" . $con->dbname . ".medico B
                                INNER JOIN " . $con->dbname . ".persona C
                                        ON B.per_id=C.per_id)
                        ON A.med_id=B.med_id
        WHERE A.hora_est_log=1 AND A.cons_id=:cons_id AND DATE(A.fecha_cita)=:fecha_cita ";
        
        //Utilities::putMessageLogFile($sql.$Ids);
        $comando = $con->createCommand($sql);
        $comando->bindParam(":cons_id", $Ids, \PDO::PARAM_INT);
        $comando->bindParam(":fecha_cita", date("Y-m-d", strtotime($Fecha)) , \PDO::PARAM_STR);
        return $comando->queryAll();
        
    }
    
    
    public static function insertarPacientesCita($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $PacId=Yii::$app->session->get('PacId', FALSE);
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array(); 
            
            $sql = "INSERT INTO " . $con->dbname . ".cita_medica
                (tur_numero,hora_id,fecha_cita,cons_id,hora_inicio,tcon_id,pac_id,cprog_id,cmde_motivo,
                 cmde_estado_asistencia,cmde_est_log)VALUES
                (:tur_numero,:hora_id,:fecha_cita,:cons_id,:hora_inicio,:tcon_id,:pac_id,:cprog_id,:cmde_motivo,
                 1,1) ";            
            $command = $con->createCommand($sql);
            $command->bindParam(":pac_id", $PacId, \PDO::PARAM_INT);//Ids 
            $command->bindParam(":tur_numero", $data[0]['tur_numero'], \PDO::PARAM_STR);
            $command->bindParam(":hora_id", $data[0]['hora_id'], \PDO::PARAM_INT);
            $command->bindParam(":cons_id", $data[0]['cons_id'], \PDO::PARAM_INT);
            $command->bindParam(":fecha_cita", date("Y-m-d", strtotime($data[0]['fecha_cita'])), \PDO::PARAM_STR); 
            $command->bindParam(":hora_inicio", $data[0]['hora_inicio'], \PDO::PARAM_STR);            
            $command->bindParam(":tcon_id", $data[0]['tcon_id'], \PDO::PARAM_INT);            
            $command->bindParam(":cprog_id", $data[0]['cprog_id'], \PDO::PARAM_INT);            
            $command->bindParam(":cmde_motivo", $data[0]['cmde_motivo'], \PDO::PARAM_STR);
            $command->execute();            
            $cita_id=$con->getLastInsertID();
 
            ####LOGS DATA
            Utilities::insertarLogs($con, $cita_id, 'cita_medica', 'Insert -> cmde_id->'.$cita_id);
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            $arroout["status"]= true;
            
            //Enviar correo electronico para activacion de cuenta
                //$nombres = $data[0]['per_nombre'];
                //$tituloMensaje = Yii::t("register","Successful Registration");
                //$asunto = Yii::t("register", "User Register") . " " . Yii::$app->params["siteName"];
                //$body = Utilities::getMailMessage("registerPaciente", array("[[user]]" => $nombres, "[[username]]" => $data[0]['per_correo'],"[[clave]]" => $password, "[[link_verification]]" => $linkActiva), Yii::$app->language);
                //Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$data[0]['per_correo'] => $data[0]['per_nombre'] . " " . $data[0]['per_apellido']], $asunto, $body);
            //Find Datos Mail
            
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }

    
    
}
