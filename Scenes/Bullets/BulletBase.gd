extends Area2D

class_name Bullet

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.RIGHT

@onready var timer: Timer = $Timer

func _ready() -> void:
	rotate(direction.angle())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += (speed * direction.normalized()) * delta


func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
