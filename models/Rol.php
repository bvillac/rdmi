<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "rol".
 *
 * @property integer $rol_id
 * @property string $rol_nombre
 * @property string $rol_color
 * @property string $rol_descripcion
 * @property string $rol_estado_activo
 * @property string $rol_fecha_creacion
 * @property string $rol_fecha_modificacion
 * @property string $rol_estado_logico
 *
 * @property GrupoRol[] $grupoRols
 */
class Rol extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'rol';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['rol_estado_activo', 'rol_estado_logico'], 'required'],
            [['rol_fecha_creacion', 'rol_fecha_modificacion'], 'safe'],
            [['rol_nombre'], 'string', 'max' => 50],
            [['rol_descripcion'], 'string', 'max' => 45],
            [['rol_estado_activo', 'rol_estado_logico'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'rol_id' => Yii::t('app', 'Rol ID'),
            'rol_nombre' => Yii::t('app', 'Rol Nombre'),
            'rol_descripcion' => Yii::t('app', 'Rol Descripcion'),
            'rol_estado_activo' => Yii::t('app', 'Rol Estado Activo'),
            'rol_fecha_creacion' => Yii::t('app', 'Rol Fecha Creacion'),
            'rol_fecha_modificacion' => Yii::t('app', 'Rol Fecha Modificacion'),
            'rol_estado_logico' => Yii::t('app', 'Rol Estado Logico'),
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGrupoRols()
    {
        return $this->hasMany(GrupoRol::className(), ['rol_id' => 'rol_id']);
    }
    
    public function getRolsByUser($id_user, $id_empresa){
        $sql = "SELECT 
                    r.rol_nombre AS rol
                FROM 
                    usuario AS u 
                    INNER JOIN grupo_rol AS gr ON u.usu_id = gr.usu_id
                    INNER JOIN rol AS r ON gr.rol_id = r.rol_id
                    INNER JOIN grupo AS g ON gr.gru_id = g.gru_id
                WHERE 
                    u.usu_id=:usu_id AND
                    gr.grol_estado_logico=1 AND 
                    gr.grol_estado_activo=1 AND 
                    u.usu_estado_logico=1 AND 
                    u.usu_estado_activo=1 AND 
                    r.rol_estado_activo=1 AND 
                    r.rol_estado_logico=1 AND
                    g.gru_estado_activo=1 AND 
                    g.gru_estado_logico=1 
                ORDER BY rol ASC";
        $comando = Yii::$app->db->createCommand($sql);
        $comando->bindParam(":usu_id", $id_user, \PDO::PARAM_INT);
        return $comando->queryAll();
    }

}
