extends CharacterBody2D

class_name Enemy

@export var SPEED: float = 100.0

var _player_ref: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)

func _physics_process(_delta: float) -> void:
	move_toward_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func move_toward_player() -> void:
	var dir: Vector2 = (_player_ref.global_position - global_position).normalized()
	velocity = dir * SPEED
	move_and_slide()
