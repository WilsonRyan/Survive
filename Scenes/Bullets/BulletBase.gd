extends Area2D

class_name Bullet

@export var direction: Vector2 = Vector2.RIGHT

@onready var timer: Timer = $Timer

var _player_ref: Player
var speed: float = 1.0

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	rotate(direction.angle())
	speed = _player_ref.bullet_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += (speed * direction.normalized()) * delta


func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
