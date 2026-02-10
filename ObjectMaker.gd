extends Node2D

const ENEMY_BAT = preload("uid://c5qr0yejdn0ia")

const VIEWPORTSIDES: Dictionary = {
	0: "Top",    # y at -100, x between -100,1380
	1: "Bottom", # y at  820, x between -100,1380
	2: "Right",  # x at 1380, y between -100, 820
	3: "Left"    # x at -100, y between -100, 820
}
const VPRIGHTDIST: int = 740
const VPLEFTDIST: int = -740
const VPTOPDIST: int = -460
const VPBOTDIST: int = 460

func _enter_tree() -> void:
	SignalHub.on_create_enemy_bat.connect(on_create_enemy_bat)


func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func on_create_enemy_bat() -> void:
	var eny: Enemy = ENEMY_BAT.instantiate()
	call_deferred("add_object", eny, rand_pos_gen())

#returns a random position outside of the viewport
func rand_pos_gen() -> Vector2:
	var spawn_side: String = VIEWPORTSIDES[randi_range(0,3)]
	var vp_center: Vector2 = get_viewport_rect().get_center()
	if spawn_side == "Top":
		return Vector2(vp_center.x + randi_range(VPLEFTDIST,VPRIGHTDIST), vp_center.y + VPTOPDIST)
	elif spawn_side == "Bottom":
		return Vector2(vp_center.x + randi_range(VPLEFTDIST,VPRIGHTDIST), vp_center.y + VPBOTDIST)
	elif spawn_side == "Left":
		return Vector2(vp_center.x + VPLEFTDIST, vp_center.y + randi_range(VPTOPDIST,VPBOTDIST))
	else: #spawn_side == "Right":
		return Vector2(vp_center.x + VPRIGHTDIST, vp_center.y + randi_range(VPTOPDIST,VPBOTDIST))
