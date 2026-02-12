extends Area2D

class_name Bullet

@export var direction: Vector2 = Vector2.RIGHT

@onready var timer: Timer = $Timer

var _player_ref: Player
var speed: float = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _player_ref == null: return
	global_position += (speed * direction.normalized()) * delta


func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
