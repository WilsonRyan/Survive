extends CharacterBody2D

class_name Player

const COIN_1 = preload("uid://cebiyk4wirbbk")
const HURT_2 = preload("uid://dwrkmew5tg5c8")


const ENEMY_BASE = preload("uid://btipv0mgh21dg")
const GAME_UI = preload("uid://8ouq6tf6kmh7")

var powerups: Dictionary = {
	"Player Speed": 200.0,
	"Fire Rate": 100.0,
	"Bullet Size": 100.0,
	"Bullet Speed": 100.0,
	"Bullet Penetration": 1.0,
	"Pickup Range": 100.0
}

#Level Up options
#@export var player_speed: float = 200.0      # upgrade is 10% increase, base is 200
#@export var fire_rate: float = 100.0         # upgrade is 10% decrease, base is 100
#@export var bullet_size: float = 100.0       # upgrade is 10% increase, base is 100
#@export var bullet_speed: float = 100.0      # upgrade is 10% increase, base is 100
#@export var bullet_penetration: float = 1.0  # upgrade is up by 1     , base is 1
#@export var pickup_range: float = 100.0      # upgrade is 20% increase, base is 100

@export var lives: int = 3                 #<-- SET HIGH FOR TESTING, base is 3

var _invisible: bool = false
var _player_dead: bool = false
var _experience: int = 0
var _level_up_amt: float = 4
var _player_level: int = 1

const GROUP_NAME: String = "Player"

@onready var shoot_timer: Timer = $ShootTimer
@onready var hurt_timer: Timer = $HurtTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: Area2D = $HitBox
@onready var sfx: AudioStreamPlayer2D = $SFX


func get_input() -> Vector2:
	return Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()



func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _ready() -> void:
	SignalHub.on_xp_gained.connect(on_xp_gained)
	SignalHub.on_powerup_picked.connect(on_powerup_picked)

func _physics_process(_delta: float) -> void:
	if _player_dead == false:
		velocity = (powerups["Player Speed"] * get_input())
		move_and_slide()


func level_up() -> void:
	_player_level += 1
	_experience = 0
	_level_up_amt = _level_up_amt * 1.2
	SignalHub.emit_on_level_up()
	get_tree().paused = true

func on_powerup_picked(pu: String) -> void:
	if pu == "Bullet Penetration":
		powerups[pu] += 1
	elif pu == "Fire Rate":
		powerups[pu] = powerups[pu] * 0.9
	elif pu == "Pickup Range":
		powerups[pu] = powerups[pu] * 1.2
	else:
		powerups[pu] = powerups[pu] * 1.1
	get_tree().paused = false

func on_xp_gained() -> void:
	_experience += 1
	if _invisible == false:
		sfx.stream = COIN_1
		sfx.volume_db = 1.0
		sfx.play()
	if _experience >= _level_up_amt:
		level_up()

func get_closest_enemy_loc() -> Vector2:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.size() == 0:
		return Vector2.UP
	var closest_eny = enemies[0]
	var min_distance = position.distance_to(closest_eny.position)
	for eny in enemies:
		var distance = position.distance_to(eny.position)
		if distance < min_distance:
			min_distance = distance
			closest_eny = eny
	return (closest_eny.global_position - global_position).normalized()



func _on_hit_box_area_entered(_area: Area2D) -> void:
	if _invisible == false:
		sfx.volume_db = 5.0
		sfx.stream = HURT_2
		sfx.play()
		lives += -1
		SignalHub.emit_on_player_takes_damage(1)
		if lives <= 0:
			queue_free()
		_invisible = true
		hurt_timer.start()
		animation_player.play("hurt")
	else:
		return

func set_dmg_enemies() -> void:
	if _invisible == true:
		hit_box.monitoring = false
	else:
		hit_box.monitoring = true

func _on_shoot_timer_timeout() -> void:
	SignalHub.emit_on_create_player_bullet(global_position, get_closest_enemy_loc()) #<---- DIRECTION HERE!
	shoot_timer.wait_time = powerups["Fire Rate"]/100
	shoot_timer.start()

func _on_hurt_timer_timeout() -> void:
	_invisible = false
