<?php

namespace app\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Paciente;

/**
 * PacienteSearch represents the model behind the search form about `app\models\Paciente`.
 */
class PacienteSearch extends Paciente
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pac_id', 'per_id'], 'integer'],
            [['pac_fecha_ingreso', 'pac_est_log', 'pac_fec_cre', 'pac_fec_mod'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = Paciente::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere([
            'pac_id' => $this->pac_id,
            'per_id' => $this->per_id,
            'pac_fecha_ingreso' => $this->pac_fecha_ingreso,
            'pac_fec_cre' => $this->pac_fec_cre,
            'pac_fec_mod' => $this->pac_fec_mod,
        ]);

        $query->andFilterWhere(['like', 'pac_est_log', $this->pac_est_log]);

        return $dataProvider;
    }
}
