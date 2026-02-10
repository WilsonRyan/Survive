extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

var ENY_SPAWN_RATE: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	SignalHub.emit_on_create_enemy_bat()
	spawn_timer.start()
	spawn_timer.wait_time = ENY_SPAWN_RATE
