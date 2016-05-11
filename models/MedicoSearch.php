<?php

namespace app\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Medico;

/**
 * MedicoSearch represents the model behind the search form about `app\models\Medico`.
 */
class MedicoSearch extends Medico
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['med_id', 'per_id'], 'integer'],
            [['med_colegiado', 'med_registro', 'med_est_log', 'med_fec_cre', 'med_fec_mod'], 'safe'],
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
        $query = Medico::find();

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
            'med_id' => $this->med_id,
            'per_id' => $this->per_id,
            'med_fec_cre' => $this->med_fec_cre,
            'med_fec_mod' => $this->med_fec_mod,
        ]);

        $query->andFilterWhere(['like', 'med_colegiado', $this->med_colegiado])
            ->andFilterWhere(['like', 'med_registro', $this->med_registro])
            ->andFilterWhere(['like', 'med_est_log', $this->med_est_log]);

        return $dataProvider;
    }
}
