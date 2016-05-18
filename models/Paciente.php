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
            //Enviar correo electronico para activacion de cuenta
                $nombres = $data[0]['per_nombre'];
                $tituloMensaje = Yii::t("register","Successful Registration");
                $asunto = Yii::t("register", "User Register") . " " . Yii::$app->params["siteName"];
                $body = Utilities::getMailMessage("registerPaciente", array("[[user]]" => $nombres, "[[username]]" => $data[0]['per_correo'],"[[clave]]" => $password, "[[link_verification]]" => $linkActiva), Yii::$app->language);
                Utilities::sendEmail($tituloMensaje, Yii::$app->params["adminEmail"], [$data[0]['per_correo'] => $data[0]['per_nombre'] . " " . $data[0]['per_apellido']], $asunto, $body);
            //Find Datos Mail
            Utilities::insertarLogs($con, $pac_id, 'paciente', 'Insert -> Pac_id,Per_id,Usu_id');
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
    
    
    
}
