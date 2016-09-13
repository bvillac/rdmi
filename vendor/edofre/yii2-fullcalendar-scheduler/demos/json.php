<?= \edofre\fullcalendarscheduler\FullcalendarScheduler::widget([
	'header'        => [
		'left'   => 'today prev,next',
		'center' => 'title',
		'right'  => 'timelineDay,timelineThreeDays,agendaWeek,month',
	],
	'clientOptions' => [
		'now'               => '2016-05-07',
		'editable'          => true, // enable draggable events
		'aspectRatio'       => 1.8,
		'scrollTime'        => '00:00', // undo default 6am scrollTime
		'defaultView'       => 'timelineDay',
		'views'             => [
			'timelineThreeDays' => [
				'type'     => 'timeline',
				'duration' => ['days' => 3],
			],
		],
		'resourceLabelText' => 'Rooms',
		'resources'         => \yii\helpers\Url::to(['scheduler/resources', 'id' => 1]),
		'events'            => \yii\helpers\Url::to(['scheduler/events', 'id' => 2]),
	],
]);
?>