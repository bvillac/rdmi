<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "modulo".
 *
 * @property integer $mod_id
 * @property string $mod_nombre
 * @property string $mod_dir_imagen
 * @property string $mod_url
 * @property integer $mod_orden
 * @property string $mod_lang_file
 * @property string $mod_estado_activo
 * @property string $mod_fecha_creacion
 * @property string $mod_fecha_modificacion
 * @property string $mod_estado_logico
 *
 * @property Aplicacion $apl
 * @property ObjetoModulo[] $objetoModulos
 */
class Modulo extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'modulo';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mod_estado_activo', 'mod_estado_logico'], 'required'],
            [['mod_orden'], 'integer'],
            [['mod_fecha_creacion', 'mod_fecha_modificacion'], 'safe'],
            [['mod_nombre'], 'string', 'max' => 50],
            [['mod_dir_imagen', 'mod_url'], 'string', 'max' => 100],
            [['mod_lang_file'], 'string', 'max' => 60],
            [['mod_estado_activo', 'mod_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'mod_id' => Yii::t('app', 'Mod ID'),
            'mod_nombre' => Yii::t('app', 'Mod Nombre'),
            'mod_dir_imagen' => Yii::t('app', 'Mod Dir Imagen'),
            'mod_url' => Yii::t('app', 'Mod Url'),
            'mod_orden' => Yii::t('app', 'Mod Orden'),
            'mod_lang_file' => Yii::t('app', 'Mod Lang File'),
            'mod_estado_activo' => Yii::t('app', 'Mod Estado Activo'),
            'mod_fecha_creacion' => Yii::t('app', 'Mod Fecha Creacion'),
            'mod_fecha_modificacion' => Yii::t('app', 'Mod Fecha Modificacion'),
            'mod_estado_logico' => Yii::t('app', 'Mod Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getObjetoModulos()
    {
        return $this->hasMany(ObjetoModulo::className(), ['mod_id' => 'mod_id']);
    }
    
    /**
     * @inheritdoc
     */
    public static function findIdentity($id) {
        return static::findOne($id);
    }
    
    /**
     * Funcion que retorna los modulos que puede visualizar un usuario
     *
     * @access public
     * @author Eduardo Cueva <ecueva@penblu.com>
     * @return mixed $menu      Arreglos de Modulos
     */
    public function getModulos() {
        $iduser    = Yii::$app->session->get('PB_iduser', FALSE);
        
        $sql = "SELECT 
                    DISTINCT(modu.mod_id),modu.*
                FROM 
                    grupo_rol as grol 
                    JOIN usuario as usu on grol.usu_id=usu.usu_id 
                    JOIN grup_obmo_grup_rol as gogr on grol.grol_id=gogr.grol_id 
                    JOIN grup_obmo as gob on gogr.gmod_id=gob.gmod_id 
                    JOIN objeto_modulo as omod on gob.omod_id=omod.omod_id 
                    JOIN modulo as modu on omod.mod_id=modu.mod_id 
                WHERE 
                    usu.usu_id=$iduser AND 
                    usu.usu_estado_logico=1 AND 
                    usu.usu_estado_activo=1 AND 
                    grol.grol_estado_logico=1 AND 
                    grol.grol_estado_activo=1 AND 
                    gogr.gogr_estado_logico=1 AND 
                    gogr.gogr_estado_activo=1 AND 
                    gob.gmod_estado_logico=1 AND 
                    gob.gmod_estado_activo=1 AND 
                    omod.omod_estado_logico=1 AND 
                    omod.omod_estado_activo=1 AND 
                    modu.mod_estado_logico=1 AND 
                    modu.mod_estado_activo=1 
                ORDER BY modu.mod_orden;";
        $res = Yii::$app->db->createCommand($sql)->queryAll();
        return $res;
    }
    
    /**
     * Funcion que retorna el link del primer modulo
     *
     * @access public
     * @author Eduardo Cueva <ecueva@penblu.com>
     * @return mixed $menu      Arreglos de Modulos
     */
    function getFirstModuleLink(){
        $iduser    = Yii::$app->session->get('PB_iduser', FALSE);
        
        $sql = "SELECT 
                    mod_url AS url
                FROM 
                    grupo_rol as grol 
                    JOIN usuario as usu on grol.usu_id=usu.usu_id 
                    JOIN grup_obmo_grup_rol as gogr on grol.grol_id=gogr.grol_id 
                    JOIN grup_obmo as gob on gogr.gmod_id=gob.gmod_id 
                    JOIN objeto_modulo as omod on gob.omod_id=omod.omod_id 
                    JOIN modulo as modu on omod.mod_id=modu.mod_id 
                WHERE 
                    usu.usu_id=$iduser AND 
                    usu.usu_estado_logico=1 AND 
                    usu.usu_estado_activo=1 AND 
                    grol.grol_estado_logico=1 AND 
                    grol.grol_estado_activo=1 AND 
                    gogr.gogr_estado_logico=1 AND 
                    gogr.gogr_estado_activo=1 AND 
                    gob.gmod_estado_logico=1 AND 
                    gob.gmod_estado_activo=1 AND 
                    omod.omod_estado_logico=1 AND 
                    omod.omod_estado_activo=1 AND 
                    modu.mod_estado_logico=1 AND 
                    modu.mod_estado_activo=1  
                ORDER BY modu.mod_orden;";
        $res = Yii::$app->db->createCommand($sql)->queryOne();
        return $res;
    }
}
