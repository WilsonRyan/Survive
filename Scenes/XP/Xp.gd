extends Area2D

class_name Xp

const GROUP_NAME: String = "XP"

@export var pickup_max_speed: float = 200.0

var _player_ref: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	add_to_group("XP")

func _physics_process(_delta: float) -> void:
	pickup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func pickup() -> void:
	if _player_ref == null: return
	var dist: float = global_position.distance_to(_player_ref.global_position)
	if dist <= _player_ref.pickup_range:
		var dir: Vector2 = (_player_ref.global_position - global_position).normalized()
		var speed: float = (pickup_max_speed/dist)
		if speed > pickup_max_speed: 
			speed = pickup_max_speed
		global_position += dir * speed


func _on_area_entered(_area: Area2D) -> void:
	SignalHub.emit_on_xp_gained()
	queue_free()
