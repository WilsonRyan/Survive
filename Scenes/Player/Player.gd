extends CharacterBody2D

class_name Player

var _speed: float = 200.0

const GROUP_NAME: String = "Player"

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	velocity = _speed * get_input()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func get_input() -> Vector2:
	return Vector2(Input.get_axis("left","right"), Input.get_axis("up","down"))
