extends CharacterBody2D

class_name Player

const ENEMY_BASE = preload("uid://btipv0mgh21dg")

@export var speed: float = 200.0
@export var fire_rate: float = 1.0

const GROUP_NAME: String = "Player"

@onready var shoot_timer: Timer = $ShootTimer


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _physics_process(_delta: float) -> void:
	velocity = speed * get_input()
	move_and_slide()


func get_input() -> Vector2:
	return Vector2(Input.get_axis("left","right"), Input.get_axis("up","down"))


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
	print("DMG")

func _on_shoot_timer_timeout() -> void:
	SignalHub.emit_on_create_player_bullet(global_position, get_closest_enemy_loc()) #<---- DIRECTION HERE!
	shoot_timer.wait_time = fire_rate
	shoot_timer.start()
