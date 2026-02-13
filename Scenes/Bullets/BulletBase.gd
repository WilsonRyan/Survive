extends Area2D

class_name Bullet

@export var direction: Vector2 = Vector2.RIGHT

@onready var timer: Timer = $Timer
@onready var sfx: AudioStreamPlayer2D = $SFX

const HIT_2 = preload("uid://chs33sfbyvdgf")
const EXPLOSION_4 = preload("uid://dlukkkd6hkkdw")

var _player_ref: Player
var speed: float = 1.0

func _ready() -> void:
	sfx.volume_db = -3.0
	sfx.stream = EXPLOSION_4
	sfx.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _player_ref == null: return
	global_position += (speed * direction.normalized()) * delta


func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	sfx.volume_db = 0.0
	sfx.stream = HIT_2
	sfx.play()
	set_deferred("visible", false)
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)

func _on_sfx_finished() -> void:
	if sfx.stream == HIT_2:
		queue_free()
