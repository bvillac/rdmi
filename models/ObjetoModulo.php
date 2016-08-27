<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "objeto_modulo".
 *
 * @property integer $omod_id
 * @property integer $mod_id
 * @property integer $omod_padre_id
 * @property string $omod_nombre
 * @property string $omod_tipo
 * @property string $omod_tipo_boton
 * @property string $omod_accion
 * @property string $omod_function
 * @property string $omod_dir_imagen
 * @property string $omod_entidad
 * @property integer $omod_orden
 * @property string $omod_estado_visible
 * @property string $omod_lang_file
 * @property string $omod_estado_activo
 * @property string $omod_fecha_creacion
 * @property string $omod_fecha_modificacion
 * @property string $omod_estado_logico
 *
 * @property GrupObmo[] $grupObmos
 * @property Modulo $mod
 * @property ObmoAcci[] $obmoAccis
 */
class ObjetoModulo extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'objeto_modulo';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mod_id', 'omod_estado_activo', 'omod_estado_logico'], 'required'],
            [['mod_id', 'omod_padre_id', 'omod_orden'], 'integer'],
            [['omod_fecha_creacion', 'omod_fecha_modificacion'], 'safe'],
            [['omod_nombre', 'omod_accion'], 'string', 'max' => 50],
            [['omod_tipo', 'omod_entidad'], 'string', 'max' => 45],
            [['omod_tipo_boton', 'omod_estado_visible', 'omod_estado_activo', 'omod_estado_logico'], 'string', 'max' => 1],
            [['omod_function', 'omod_dir_imagen'], 'string', 'max' => 100],
            [['omod_lang_file'], 'string', 'max' => 60]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'omod_id' => Yii::t('app', 'Omod ID'),
            'mod_id' => Yii::t('app', 'Mod ID'),
            'omod_padre_id' => Yii::t('app', 'Omod Padre ID'),
            'omod_nombre' => Yii::t('app', 'Omod Nombre'),
            'omod_tipo' => Yii::t('app', 'Omod Tipo'),
            'omod_tipo_boton' => Yii::t('app', 'Omod Tipo Boton'),
            'omod_accion' => Yii::t('app', 'Omod Accion'),
            'omod_function' => Yii::t('app', 'Omod Function'),
            'omod_dir_imagen' => Yii::t('app', 'Omod Dir Imagen'),
            'omod_entidad' => Yii::t('app', 'Omod Entidad'),
            'omod_orden' => Yii::t('app', 'Omod Orden'),
            'omod_estado_visible' => Yii::t('app', 'Omod Estado Visible'),
            'omod_lang_file' => Yii::t('app', 'Omod Lang File'),
            'omod_estado_activo' => Yii::t('app', 'Omod Estado Activo'),
            'omod_fecha_creacion' => Yii::t('app', 'Omod Fecha Creacion'),
            'omod_fecha_modificacion' => Yii::t('app', 'Omod Fecha Modificacion'),
            'omod_estado_logico' => Yii::t('app', 'Omod Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGrupObmos()
    {
        return $this->hasMany(GrupObmo::className(), ['omod_id' => 'omod_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMod()
    {
        return $this->hasOne(Modulo::className(), ['mod_id' => 'mod_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getObmoAccis()
    {
        return $this->hasMany(ObmoAcci::className(), ['omod_id' => 'omod_id']);
    }
    
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    /**
     * Funcion que devuelve los objetos modulos dado un modulo
     *
     * @access public
     * @author Eduardo Cueva <ecueva@penblu.com>
     * 
     * @param string $route Ruta de Objeto Modulo
     * @return mixed       Arreglos de Objetos Modulos
     */
    public static function findIdentityByEntity($route){
        return static::findOne(['omod_entidad' => $route]);
    }
    
    
    
    /**
     * Funcion que devuelve los formularios Secuandrios de Cada Modulo
     * @access public
     * @return mixed $menu      Arreglos de Objetos Modulos
     */
    public function getObjetoModulosFormulario($moduloid) {
        $RolId= Yii::$app->session->get('RolId', FALSE);
        $con = \Yii::$app->db;
        $sql = "select b.omod_id,b.omod_padre_id,b.omod_nombre,b.omod_entidad,b.omod_lang_file,b.omod_tipo, 
                    b.omod_tipo_boton,b.omod_accion, b.omod_function, b.omod_dir_imagen, b.omod_orden
                    from " . $con->dbname . ".modulo a
                      inner join (" . $con->dbname . ".objeto_modulo b
                          inner join (" . $con->dbname . ".omodulo_rol c
                              inner join " . $con->dbname . ".rol d on c.rol_id=d.rol_id)
                          on b.omod_id=c.omod_id and c.omrol_est_log=1)
                      on b.mod_id=a.mod_id
                  where a.mod_estado_logico=1 and b.mod_id=:mod_id and b.omod_tipo='S' 
                  and d.rol_id=:rol_id order by b.omod_orden ";      
        $comando = $con->createCommand($sql);
        $comando->bindParam(":rol_id", $RolId, \PDO::PARAM_INT);
        $comando->bindParam(":mod_id", $moduloid, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    /**
     * Función para obtener arreglo de objetos modulos por id de objeto modulo padre
     * @access public
     * @param string $id_module        Id del Modulo
     * @param string $id_omod          Id del Objeto Modulo
     * @param string $id_omodpadre     Id del Objeto Modulo padre
     * @return mixed                   Retorna un array de los Objetos Modulos hijos del objeto modulo con la ruta o entidad especificada en $route
     *                      
     * */
    public function getObjModHijosXObjModPadre($id_module, $id_omod, $id_omodpadre) {
        $RolId= Yii::$app->session->get('RolId', FALSE);
        $con = \Yii::$app->db;
        $sql = "select b.* from rdmi.objeto_modulo b
                          inner join (rdmi.omodulo_rol c
                              inner join rdmi.rol d on c.rol_id=d.rol_id)
                          on b.omod_id=c.omod_id
                  where b.omod_estado_logico=1 and d.rol_id=:rol_id and b.omod_id=:omod_id and b.mod_id=:mod_id 
                  and b.omod_padre_id=:omod_padre order by b.omod_orden; ";
        $comando = $con->createCommand($sql);
        $comando->bindParam(":mod_id", $id_module, \PDO::PARAM_INT);
        $comando->bindParam(":rol_id", $RolId, \PDO::PARAM_INT);
        $comando->bindParam(":omod_padre", $id_omodpadre, \PDO::PARAM_INT);
        $comando->bindParam(":omod_id", $id_omod, \PDO::PARAM_INT);
        return $comando->queryAll();
    }
    
    /**
     * Función para obtener un modulo dado el id del objeto modulo
     * @param  $omod_id          Id del objeto modulo 
     * @return mixed             Objeto con los datos de un modulo
     */
    public function getModuleByObjModule($omod_id){
        $RolId= Yii::$app->session->get('RolId', FALSE);
        $con = \Yii::$app->db;
        $sql = "select distinct(a.mod_id),a.*
                    from " . $con->dbname . ".modulo a
                      inner join (" . $con->dbname . ".objeto_modulo b
                          inner join (" . $con->dbname . ".omodulo_rol c
                              inner join " . $con->dbname . ".rol d on c.rol_id=d.rol_id)
                          on b.omod_id=c.omod_id)
                      on b.mod_id=a.mod_id
                  where a.mod_estado_logico=1 and d.rol_id=:rol_id order by b.omod_orden ";  
        $comando = $con->createCommand($sql);
        $comando->bindParam(":rol_id", $RolId, \PDO::PARAM_INT);
        return $comando->queryOne();
    }

    /**
     * Función para obtener todos los padres de un objeto modulo
     *
     * @author Eduardo Cueva <ecueva@penblu.com>
     * @param  int   $id_objModulo          Id del objeto modulo 
     * @param  mixed $obj                   Objeto que contiene los padres. Inicialmente esta vacio
     * @return mixed                        Objeto con los datos de los padres de un objeto modulo
     */
    public static function getParentByObjModule($id_objModulo, $obj) {
        $sql = "SELECT * FROM objeto_modulo WHERE omod_id=:id_omod AND omod_estado_logico=1 AND omod_estado_activo=1";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":id_omod", $id_objModulo, \PDO::PARAM_INT);
        $fila = $comando->queryOne();

        if (isset($fila)) {
            if ($id_objModulo == $fila['omod_padre_id']) {
                $objmod_lang_file = isset($fila["omod_lang_file"])?$fila["omod_lang_file"]:"menu";
                $omod_nombre = Yii::t($objmod_lang_file, $fila['omod_nombre']);
                $obj[] = array($omod_nombre, $fila['omod_entidad']); // se agrega al padre
                $mod = Modulo::findIdentity($fila['mod_id']); // se agrega al modulo
                $mod_lang_file = isset($mod["mod_lang_file"])?$mod["mod_lang_file"]:"menu";
                $mod_nombre = Yii::t($mod_lang_file, $mod['mod_nombre']);
                $obj[] = array($mod_nombre, $mod['mod_url']);
                return $obj;
            } else {
                $objmod_lang_file = isset($fila["omod_lang_file"])?$fila["omod_lang_file"]:"menu";
                $omod_nombre = Yii::t($objmod_lang_file, $fila['omod_nombre']);
                $obj[] = array($omod_nombre, $fila['omod_entidad']);
                $obj = self::getParentByObjModule($fila['omod_padre_id'], $obj);
                return $obj;
            }
        } else
            return array();
    }
    
    
}
