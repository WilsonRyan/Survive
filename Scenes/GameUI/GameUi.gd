extends Control


@onready var timer_label: Label = $MarginContainer/VBoxContainer/TimerLabel
@onready var game_timer: Timer = $GameTimer

var _time: float = 0.0

func _unhandled_input(_event: InputEvent) -> void:
	GameManager.navigate_scenes()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_time += delta
	timer_label.text = "%.1fs" % _time
