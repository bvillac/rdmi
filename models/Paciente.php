<?php

namespace app\models;
use yii\data\ArrayDataProvider;
use app\models\Persona;


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
    
    public static function consultarPacientes($data){
        $con = \Yii::$app->db;
        $sql = "SELECT a.pac_id Ids,a.per_id,b.per_ced_ruc DNI,CONCAT(b.per_nombre,' ',b.per_apellido) Nombres,a.pac_est_log Estado
                FROM " . $con->dbname . ".paciente a
                  INNER JOIN " . $con->dbname . ".persona b
                    ON a.per_id=b.per_id
            WHERE a.pac_est_log=1 ";
        $sql .= "ORDER BY Nombres DESC ";
        
        //Utilities::putMessageLogFile($sql);
        $comando = $con->createCommand($sql);

        $resultData=$comando->queryAll();
        $dataProvider = new ArrayDataProvider([
            'key' => 'Ids',
            'allModels' => $resultData,
            'pagination' => [
                'pageSize' => Yii::$app->params["pageSize"],
            ],
            'sort' => [              
                'attributes' => ['Ids','DNI','Nombres'],
            ],
        ]);

        return $dataProvider;
    }
    
    public function buscarPacienteID($ids){
        $con = \Yii::$app->db;   
        $sql = "SELECT pac_id,per_id FROM " . $con->dbname . ".paciente WHERE pac_id=:pac_id ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":pac_id", $ids, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    
    /* INSERTAR DATOS */
    public function insertarPacientes($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();
            Persona::insertarDataPerfil($con, $data);
            $per_id=$con->getLastInsertID();//IDS de la Persona
            Persona::insertarDataPerfilDatoAdicional($con, $data, $per_id);
            $this->insertarDataPaciente($con, $data, $per_id);
            $pac_id=$con->getLastInsertID();
            $password=  Utilities::generarCodigoKey(8);//Passw Generado Automaticamente
            $linkActiva=Usuario::crearLinkActivacion();
            Usuario::insertarDataUser($con, $data[0]['per_correo'], $password, $per_id,$linkActiva);            
            Utilities::insertarLogs($con, $pac_id, 'paciente', 'Insert -> Pac_id,Per_id,Usu_id');
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            $arroout["status"]= true;
            
            //Enviar correo electronico para activacion de cuenta
                $nombres = $data[0]['per_nombre'];
                $tituloMensaje = Yii::t("register","Successful Registration");
                $asunto = Yii::t("register", "User Register") . " " . Yii::$app->params["siteName"];
                $body = Utilities::getMailMessage("registerPaciente", array("[[user]]" => $nombres, "[[username]]" => $data[0]['per_correo'],"[[clave]]" => $password, "[[link_verification]]" => $linkActiva), Yii::$app->language);
                Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$data[0]['per_correo'] => $data[0]['per_nombre'] . " " . $data[0]['per_apellido']], $asunto, $body);
            //Find Datos Mail
            
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    
    /* ACTUALIZAR DATOS */
    public function actualizarPacientes($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();
            $pac_id=$data[0]['pac_id'];
            $this->updateDataPaciente($con, $data, $pac_id);
            Persona::actualizarDataPerfil($con,$data);
            Persona::actualizarDataAdicional($con,$data);
            Utilities::insertarLogs($con, $pac_id, 'paciente', 'Update -> Pac_id,Per_id');
            $trans->commit();
            $con->close();
            //RETORNA DATOS 
            $arroout["status"]= true;
            return $arroout;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            $arroout["status"]= false;
            return $arroout;
        }
    }
    
    
    private function insertarDataPaciente($con, $data, $per_id) {
        //Datos Adicionales
        $sql = "INSERT INTO " . $con->dbname . ".paciente
            (per_id,pac_est_log)VALUES(:per_id,1);";
        $command = $con->createCommand($sql);
        $command->bindParam(":per_id", $per_id, \PDO::PARAM_INT); //Id Comparacion
        $command->execute();
    }
    
    
    public static function eliminarPaciente($data) {
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $ids = isset($data['ids']) ? base64_decode($data['ids']) :NULL;
            $sql = "UPDATE " . $con->dbname . ".paciente SET pac_est_log=0 WHERE pac_id=:pac_id ";
            $command = $con->createCommand($sql);
            $command->bindParam(":pac_id", $ids, \PDO::PARAM_INT);
            $command->execute();
            $trans->commit();
            $con->close();
            return true;
        } catch (\Exception $e) {
            $trans->rollBack();
            $con->close();
            //throw $e;
            return false;
        }
    }
    
    private function updateDataPaciente($con, $data, $pac_id) {
        //Datos Adicionales        
        $sql = "UPDATE " . $con->dbname . ".paciente
            SET pac_fec_mod = CURRENT_TIMESTAMP()
        WHERE pac_id = :pac_id; ";        
        $command = $con->createCommand($sql);
        $command->bindParam(":pac_id", $pac_id, \PDO::PARAM_INT); //Id Comparacion
        $command->execute();
    }
    
    public static function retornarPersonaPaciente($valor, $op) {
        $con = \Yii::$app->db;
        $rawData = array();
        //Patron de Busqueda
        /* http://www.mclibre.org/consultar/php/lecciones/php_expresiones_regulares.html */
        $patron = "/^[[:digit:]]+$/"; //Los patrones deben empezar y acabar con el carácter / (barra).
        if (preg_match($patron, $valor)) {
            $op = "CED"; //La cadena son sólo números.
        } else {
            $op = "NOM"; //La cadena son Alfanumericos.
            //Las separa en un array 
            $aux = explode(" ", $valor);
            $condicion = " ";
            for ($i = 0; $i < count($aux); $i++) {
                //Crea la Sentencia de Busqueda
                $condicion .=" AND (A.per_nombre LIKE '%$aux[$i]%' OR A.per_apellido LIKE '%$aux[$i]%' ) ";
            }
        }
        
        $sql = "SELECT B.pac_id Ids,A.per_ced_ruc Cedula,CONCAT(A.per_nombre,' ',A.per_apellido) Nombres
                FROM " . $con->dbname . ".paciente B
                INNER JOIN " . $con->dbname . ".persona A ON A.per_id=B.per_id AND A.per_est_log=1
            WHERE B.pac_est_log=1 ";

        switch ($op) {
            case 'CED':
                $sql .=" AND A.per_ced_ruc LIKE '%$valor%' ";
                break;
            case 'NOM':
                $sql .=$condicion;
                break;
            default:
        }
        $sql .= " GROUP BY A.per_ced_ruc ";
        $sql .= " LIMIT " . Yii::$app->params["limitRow"];
        //Utilities::putMessageLogFile($sql);
        $comando = $con->createCommand($sql);
        //$comando->bindParam(":valor", $ids, \PDO::PARAM_STR);
        return $comando->queryAll();
    }
    
    
    
    
}
