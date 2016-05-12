<?php

namespace app\models;

use Yii;
use yii\data\ArrayDataProvider;

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
 * @property Resultados[] $resultados
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

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getResultados()
    {
        return $this->hasMany(Resultados::className(), ['med_id' => 'med_id']);
    }
    
    public static function consultarMedicos($data){
        $con = \Yii::$app->db;
        
        $sql = "SELECT a.med_id Ids,a.med_registro Registro,a.med_est_log Estado,CONCAT(b.per_nombre,' ',b.per_apellido) Nombres,d.emp_nombre Empresa
                    FROM " . $con->dbname . ".medico a
                      INNER JOIN " . $con->dbname . ".persona b
                          ON a.per_id=b.per_id
                      INNER JOIN (" . $con->dbname . ".medico_empresa c
                              LEFT JOIN " . $con->dbname . ".empresa d
                                ON c.emp_id=d.emp_id)
                          ON a.med_id=c.med_id
                  WHERE a.med_est_log=1 ";        
        $sql .= "ORDER BY b.per_nombre DESC ";
        
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
                'attributes' => ['Ids','Nombres','Registro','Empresa'],
            ],
        ]);

        return $dataProvider;
    }
    
    public static function getEspecilidades() {
        $con = \Yii::$app->db;
        $sql="SELECT esp_id,esp_nombre FROM " . $con->dbname . ".especialidad WHERE esp_est_log=1 ";
        $comando = $con->createCommand($sql);
        return $comando->queryAll();
    }
    
    /* ACTUALIZAR DATOS */
    public function insertarMedicos($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();    
            //$reg_id= Yii::$app->session->get('PB_idregister', FALSE);
            $this->actualizarDataPerfil($con,$data); 
            //$ftem_id=$data_1[0]['ftem_id'];//$con->getLastInsertID();//IDS Formulario Temp
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
    
    /* ACTUALIZAR DATOS */
    public function actualizarMedicos($data) {
        $arroout = array();
        $con = \Yii::$app->db;
        $trans = $con->beginTransaction();
        try {
            $data = isset($data['DATA']) ? $data['DATA'] : array();    
            //$reg_id= Yii::$app->session->get('PB_idregister', FALSE);
            $this->actualizarDataPerfil($con,$data); 
            //$ftem_id=$data_1[0]['ftem_id'];//$con->getLastInsertID();//IDS Formulario Temp
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
    
    private function insertarDataSolicitud($con,$data_1,$data_2,$data_3,$reg_id) {
        $doc_numero='00001';
        $sql = "INSERT INTO " . $con->dbname . ".mce_formulario_temp
            (doc_numero,can_id,reg_id,ind_id,ftem_condiciones,ftem_origen,ftem_personeria,ftem_nombre,ftem_apellido,ftem_cedula,ftem_ruc,
             ftem_direccion,ftem_sitio_web,ftem_contacto,ftem_cargo_persona,ftem_contacto_cargo,ftem_contacto_correo,ftem_contacto_telefono,
             pai_id_ext,ftem_ciudad_ext,ftem_exporta_servicio,ftem_definicion_sector,
             ftem_correo,ftem_telefono,ftem_tipo_pyme,ftem_cedula_file,ftem_ruc_file,ftem_cert_file,ftem_trayectoria,
             ftem_decl_jurada_file,ftem_trayectoria_file,ftem_genero,ftem_raza_etnica,
             ftem_giroprincipal,ftem_vision,ftem_mision,ftem_referencia,ftem_estado,ftem_estado_logico,obj_id,ftem_detalle,
             umar_id,ftem_registro_sanitario_file,ftem_perm_func_mitur_file,ftem_cert_super_compania_file,             
             ftem_cert_obligaciones_file,ftem_razon_social,ftem_imp_renta_file)VALUES
            (:doc_numero,:can_id,:reg_id,:ind_id,:ftem_condiciones,:ftem_origen,:ftem_personeria,:ftem_nombre,:ftem_apellido,:ftem_cedula,:ftem_ruc,
             :ftem_direccion,:ftem_sitio_web,:ftem_contacto,:ftem_cargo_persona,:ftem_contacto_cargo,:ftem_contacto_correo,:ftem_contacto_telefono,
             :pai_id_ext,:ftem_ciudad_ext,:ftem_exporta_servicio,:ftem_definicion_sector,
             :ftem_correo,:ftem_telefono,:ftem_tipo_pyme,:ftem_cedula_file,:ftem_ruc_file,:ftem_cert_file,:ftem_trayectoria,
             :ftem_decl_jurada_file,:ftem_trayectoria_file,:ftem_genero,:ftem_raza_etnica,
             :ftem_giroprincipal,:ftem_vision,:ftem_mision,:ftem_referencia,1,1,:obj_id,:ftem_detalle,:umar_id,
             :ftem_registro_sanitario_file,:ftem_perm_func_mitur_file,:ftem_cert_super_compania_file,             
             :ftem_cert_obligaciones_file,:ftem_razon_social,:ftem_imp_renta_file)";
        //Utilities::putMessageLogFile($sql);
        //PASO 1
        $command = $con->createCommand($sql);
        $command->bindParam(":doc_numero",$doc_numero, PDO::PARAM_STR);
        $command->bindParam(":can_id", $data_1[0]['can_id'], PDO::PARAM_INT);
        $command->bindParam(":reg_id", $reg_id, PDO::PARAM_INT);//ID REGISTRO SESION
        $command->bindParam(":ind_id", $data_1[0]['ind_id'], PDO::PARAM_INT);//ID SECTOR       
        $command->bindParam(":ftem_origen", $data_1[0]['ftem_origen'], PDO::PARAM_INT);
        $command->bindParam(":ftem_personeria", $data_1[0]['ftem_personeria'], PDO::PARAM_INT);
        $command->bindParam(":ftem_nombre", $data_1[0]['ftem_nombre'], PDO::PARAM_STR);
        $command->bindParam(":ftem_apellido", $data_1[0]['ftem_apellido'], PDO::PARAM_STR);
        $command->bindParam(":ftem_cedula", $data_1[0]['ftem_cedula'], PDO::PARAM_STR);
        $command->bindParam(":ftem_ruc", $data_1[0]['ftem_ruc'], PDO::PARAM_STR);
        $command->bindParam(":ftem_direccion", $data_1[0]['ftem_direccion'], PDO::PARAM_STR);
        $command->bindParam(":ftem_sitio_web", $data_1[0]['ftem_sitio_web'], PDO::PARAM_STR);
        $command->bindParam(":ftem_contacto", $data_1[0]['ftem_contacto'], PDO::PARAM_STR);
        $command->bindParam(":ftem_cargo_persona", $data_1[0]['ftem_cargo_persona'], PDO::PARAM_STR);  
        $command->bindParam(":ftem_contacto_cargo", $data_1[0]['ftem_contacto_cargo'], PDO::PARAM_STR);
        $command->bindParam(":ftem_contacto_correo", $data_1[0]['ftem_contacto_correo'], PDO::PARAM_STR);
        $command->bindParam(":ftem_contacto_telefono", $data_1[0]['ftem_contacto_telefono'], PDO::PARAM_STR);
        $command->bindParam(":pai_id_ext", $data_1[0]['pai_id_ext'], PDO::PARAM_INT);
        $command->bindParam(":ftem_ciudad_ext", $data_1[0]['ftem_ciudad_ext'], PDO::PARAM_STR);
        $command->bindParam(":ftem_correo", $data_1[0]['ftem_correo'], PDO::PARAM_STR);
        $command->bindParam(":ftem_telefono", $data_1[0]['ftem_telefono'], PDO::PARAM_STR);
        $command->bindParam(":ftem_tipo_pyme", $data_1[0]['ftem_tipo_pyme'], PDO::PARAM_INT);
        $command->bindParam(":ftem_cedula_file", $data_1[0]['ftem_cedula_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_ruc_file", $data_1[0]['ftem_ruc_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_cert_file", $data_1[0]['ftem_cert_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_razon_social", $data_1[0]['ftem_razon_social'], PDO::PARAM_STR);
        $command->bindParam(":ftem_genero", $data_1[0]['ftem_genero'], PDO::PARAM_INT);
        $command->bindParam(":ftem_raza_etnica", $data_1[0]['ftem_raza_etnica'], PDO::PARAM_INT);
        $command->bindParam(":ftem_registro_sanitario_file", $data_1[0]['ftem_registro_sanitario_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_perm_func_mitur_file", $data_1[0]['ftem_perm_func_mitur_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_cert_super_compania_file", $data_1[0]['ftem_cert_super_compania_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_cert_obligaciones_file", $data_1[0]['ftem_cert_obligaciones_file'], PDO::PARAM_STR);
        

        //PASO 2
        $command->bindParam(":ftem_trayectoria_file", $data_2[0]['ftem_trayectoria_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_trayectoria", $data_2[0]['ftem_trayectoria'], PDO::PARAM_STR);
        //$command->bindParam(":ftem_motivo", $data_2[0]['ftem_motivo'], PDO::PARAM_STR);
        $command->bindParam(":ftem_giroprincipal", $data_2[0]['ftem_giroprincipal'], PDO::PARAM_STR);
        $command->bindParam(":ftem_vision", $data_2[0]['ftem_vision'], PDO::PARAM_STR);
        $command->bindParam(":ftem_mision", $data_2[0]['ftem_mision'], PDO::PARAM_STR);//Dato Eliminado
        $command->bindParam(":ftem_referencia", $data_2[0]['ftem_referencia'], PDO::PARAM_STR);
        $command->bindParam(":obj_id", $data_2[0]['obj_id'], PDO::PARAM_INT);
        $command->bindParam(":ftem_detalle", $data_2[0]['ftem_detalle'], PDO::PARAM_STR);
        $command->bindParam(":ftem_imp_renta_file", $data_2[0]['ftem_imp_renta_file'], PDO::PARAM_STR);

        //PASO 3
        $command->bindParam(":ftem_condiciones", $data_3[0]['ftem_condiciones'], PDO::PARAM_INT);//Acepta Condiciones
        $command->bindParam(":ftem_decl_jurada_file", $data_3[0]['ftem_decl_jurada_file'], PDO::PARAM_STR);
        $command->bindParam(":ftem_exporta_servicio", $data_3[0]['ftem_exporta_servicio'], PDO::PARAM_STR);
        $command->bindParam(":ftem_definicion_sector", $data_3[0]['ftem_definicion_sector'], PDO::PARAM_STR);
        $command->bindParam(":umar_id", $data_3[0]['umar_id'], PDO::PARAM_INT);
        $command->execute();
    }
    
    
    
    
}
