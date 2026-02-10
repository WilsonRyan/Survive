extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var progression_timer: Timer = $ProgressionTimer

var ENY_SPAWN_RATE: float = 1.0


func _on_spawn_timer_timeout() -> void:
	SignalHub.emit_on_create_enemy_bat()
	spawn_timer.wait_time = spawn_timer.wait_time * (0.9999)
	spawn_timer.start()

func _on_progression_timer_timeout() -> void:
	spawn_timer.wait_time = spawn_timer.wait_time * 0.99
	progression_timer.start()
	print(spawn_timer.wait_time)
