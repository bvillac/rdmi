<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "accion".
 *
 * @property integer $acc_id
 * @property string $acc_nombre
 * @property string $acc_url_accion
 * @property string $acc_tipo
 * @property string $acc_descripcion
 * @property string $acc_lang_file
 * @property string $acc_dir_imagen
 * @property string $acc_estado_activo
 * @property string $acc_fecha_creacion
 * @property string $acc_fecha_modificacion
 * @property string $acc_estado_logico
 *
 * @property ObmoAcci[] $obmoAccis
 */
class Accion extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'accion';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['acc_estado_activo', 'acc_estado_logico'], 'required'],
            [['acc_fecha_creacion', 'acc_fecha_modificacion'], 'safe'],
            [['acc_nombre', 'acc_url_accion'], 'string', 'max' => 50],
            [['acc_tipo'], 'string', 'max' => 45],
            [['acc_descripcion'], 'string', 'max' => 250],
            [['acc_lang_file'], 'string', 'max' => 60],
            [['acc_dir_imagen'], 'string', 'max' => 100],
            [['acc_estado_activo', 'acc_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'acc_id' => Yii::t('app', 'Acc ID'),
            'acc_nombre' => Yii::t('app', 'Acc Nombre'),
            'acc_url_accion' => Yii::t('app', 'Acc Url Accion'),
            'acc_tipo' => Yii::t('app', 'Acc Tipo'),
            'acc_descripcion' => Yii::t('app', 'Acc Descripcion'),
            'acc_lang_file' => Yii::t('app', 'Acc Lang File'),
            'acc_dir_imagen' => Yii::t('app', 'Acc Dir Imagen'),
            'acc_estado_activo' => Yii::t('app', 'Acc Estado Activo'),
            'acc_fecha_creacion' => Yii::t('app', 'Acc Fecha Creacion'),
            'acc_fecha_modificacion' => Yii::t('app', 'Acc Fecha Modificacion'),
            'acc_estado_logico' => Yii::t('app', 'Acc Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getObmoAccis()
    {
        return $this->hasMany(ObmoAcci::className(), ['acc_id' => 'acc_id']);
    }

    /**
     * @inheritdoc
     * @return AccionQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new AccionQuery(get_called_class());
    }
    
    /**
     * Función para Obtener el menu de acciones 
     * Los Tipos de botones registrados en el Objeto Modulo son:
     * 0=>Botones normales que ejecutan un accion o entidad
     * 1=>Botones que ejecutan una funcion javascript
     * 
     * Los tipos de objetos modulos son:
     * P=>Principal
     * S=>Secundario
     * A=>Accion
     *
     * @author Eduardo Cueva <ecueva@penblu.com>
     * @access public
     * @param  int        $omod_id    Id del Objeto Modulo
     * @return mixed                  Devuelve un array para construccion de Menus
     */
    public function getAccionesXObjModulo($omod_id){
        $usu_id    = Yii::$app->session->get('PB_iduser', FALSE);
        $idempresa = Yii::$app->session->get('PB_idempresa', FALSE);
        $sql = "SELECT 
                    om.omod_id,
                    om.omod_padre_id,
                    om.omod_nombre,
                    om.omod_entidad,
                    om.omod_lang_file,
                    om.omod_tipo,
                    om.omod_tipo_boton,
                    om.omod_accion,
                    om.omod_function,
                    om.omod_dir_imagen,
                    om.omod_orden,
                    ac.acc_id,
                    ac.acc_nombre,
                    ac.acc_url_accion,
                    ac.acc_tipo,
                    ac.acc_lang_file,
                    ac.acc_dir_imagen
                FROM 
                    objeto_modulo AS om 
                    INNER JOIN grup_obmo AS go ON om.omod_id = go.omod_id 
                    INNER JOIN grup_obmo_grup_rol AS gg ON go.gmod_id = gg.gmod_id
                    INNER JOIN grupo_rol AS gr ON gg.grol_id = gr.grol_id
                    INNER JOIN usuario AS us ON gr.usu_id = us.usu_id
                    INNER JOIN obmo_acci AS oa ON om.omod_id = oa.omod_id 
                    INNER JOIN accion AS ac ON oa.acc_id = ac.acc_id 
                WHERE 
                    om.omod_padre_id=:omod_id AND 
                    om.omod_tipo='A' AND 
                    us.usu_id=:usu_id AND 
                    go.gmod_estado_logico=1 AND 
                    go.gmod_estado_activo=1 AND 
                    gg.gogr_estado_logico=1 AND 
                    gg.gogr_estado_activo=1 AND 
                    gr.grol_estado_logico=1 AND 
                    gr.grol_estado_activo=1 AND 
                    us.usu_estado_logico=1 AND 
                    us.usu_estado_activo=1 AND 
                    om.omod_estado_logico=1 AND 
                    om.omod_estado_activo=1 AND 
                    om.omod_estado_visible=1 AND
                    oa.oacc_estado_activo=1 AND 
                    oa.oacc_estado_logico=1 AND 
                    ac.acc_estado_activo=1 AND 
                    ac.acc_estado_logico=1 
                ORDER BY om.omod_nombre;";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":omod_id", $omod_id, \PDO::PARAM_INT);
        $comando->bindParam(":usu_id", $usu_id, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    public static function generateBehaviorByActions($objmod_id = NULL){
        if(!isset($objmod_id)){
            $session = Yii::$app->session;
            $objmod_id = $session->get('PB_objmodule_id');
        }
        $usu_id    = Yii::$app->session->get('PB_iduser', FALSE);
        $idempresa = Yii::$app->session->get('PB_idempresa', FALSE);
        
        $sql = "SELECT 
                    om.omod_entidad AS route
                FROM 
                    objeto_modulo AS om 
                    INNER JOIN grup_obmo AS go ON om.omod_id = go.omod_id 
                    INNER JOIN grup_obmo_grup_rol AS gg ON go.gmod_id = gg.gmod_id
                    INNER JOIN grupo_rol AS gr ON gg.grol_id = gr.grol_id
                    INNER JOIN usuario AS us ON gr.usu_id = us.usu_id
                    -- INNER JOIN obmo_acci AS oa ON om.omod_id = oa.omod_id 
                    -- INNER JOIN accion AS ac ON oa.acc_id = ac.acc_id 
                WHERE 
                    om.omod_id=:omod_id AND 
                    -- om.omod_padre_id=:omod_id AND 
                    om.omod_tipo='A' AND 
                    us.usu_id=:usu_id AND 
                    go.gmod_estado_logico=1 AND 
                    go.gmod_estado_activo=1 AND 
                    gg.gogr_estado_logico=1 AND 
                    gg.gogr_estado_activo=1 AND 
                    gr.grol_estado_logico=1 AND 
                    gr.grol_estado_activo=1 AND 
                    us.usu_estado_logico=1 AND 
                    us.usu_estado_activo=1 AND 
                    om.omod_estado_logico=1 AND 
                    om.omod_estado_activo=1 AND 
                    om.omod_estado_visible=0 
                    -- oa.oacc_estado_activo=1 AND 
                    -- oa.oacc_estado_logico=1 AND 
                    -- ac.acc_estado_activo=1 AND 
                    -- ac.acc_estado_logico=1 
                UNION
                SELECT 
                    om.omod_entidad AS route
                FROM 
                    objeto_modulo AS om 
                    INNER JOIN grup_obmo AS go ON om.omod_id = go.omod_id 
                    INNER JOIN grup_obmo_grup_rol AS gg ON go.gmod_id = gg.gmod_id
                    INNER JOIN grupo_rol AS gr ON gg.grol_id = gr.grol_id
                    INNER JOIN usuario AS us ON gr.usu_id = us.usu_id
                WHERE 
                    om.omod_padre_id=:omod_id AND 
                    om.omod_tipo='P' AND 
                    us.usu_id=:usu_id AND 
                    go.gmod_estado_logico=1 AND 
                    go.gmod_estado_activo=1 AND 
                    gg.gogr_estado_logico=1 AND 
                    gg.gogr_estado_activo=1 AND 
                    gr.grol_estado_logico=1 AND 
                    gr.grol_estado_activo=1 AND 
                    us.usu_estado_logico=1 AND 
                    us.usu_estado_activo=1 
                ORDER BY route;";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":omod_id", $objmod_id, \PDO::PARAM_INT);
        $comando->bindParam(":usu_id", $usu_id, \PDO::PARAM_INT);
        $result = $comando->queryAll();
        $actions = array();
        $actionsArr = "";
        
        foreach($result as $key => $value){
            $link = $value["route"];
            $arr_link = explode("/",$link);
            $cont = count($arr_link) - 1;
            $actions[] = $arr_link[$cont];
        }
        if(count($actions)>0){
            return [
                "access" => [
                    'class' => \yii\filters\AccessControl::className(),
                    'rules' => [
                        [
                            'allow'   => true,
                            'actions' => $actions,
                            'roles'   => ['@'],
                        ],
                    ],
            ]];
        }else{
            return [
                "access" => [
                    'class' => \yii\filters\AccessControl::className(),
                    'rules' => [
                        [
                            'allow'   => false,
                            'roles'   => ['@'],
                        ],
                    ],
            ]];
        }
        
    }
    
}
