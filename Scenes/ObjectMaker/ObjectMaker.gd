extends Node2D

const ENEMY_BAT = preload("uid://c5qr0yejdn0ia")
const BULLET_PLAYER = preload("uid://c46yncpjk0pt2")
const XP = preload("uid://ta5s77ibhxf0")

var _player_ref: Player

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
	SignalHub.on_create_player_bullet.connect(on_create_player_bullet)
	SignalHub.on_create_xp.connect(on_create_xp)
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)

func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func on_create_xp(pos: Vector2) -> void:
	var xp: Xp = XP.instantiate()
	call_deferred("add_object", xp, pos)

func on_create_player_bullet(pos: Vector2, dir: Vector2) -> void:
	var pb: Bullet = BULLET_PLAYER.instantiate()
	pb.direction = dir
	call_deferred("add_object", pb, pos)

func on_create_enemy_bat() -> void:
	var eny: Enemy = ENEMY_BAT.instantiate()
	call_deferred("add_object", eny, rand_pos_gen())

#returns a random position outside of the viewport
func rand_pos_gen() -> Vector2:
	var spawn_side: String = VIEWPORTSIDES[randi_range(0,3)]
	if _player_ref == null:
		return global_position
	var vp_center: Vector2 = _player_ref.global_position
	if spawn_side == "Top":
		return Vector2(vp_center.x + randi_range(VPLEFTDIST,VPRIGHTDIST), vp_center.y + VPTOPDIST)
	elif spawn_side == "Bottom":
		return Vector2(vp_center.x + randi_range(VPLEFTDIST,VPRIGHTDIST), vp_center.y + VPBOTDIST)
	elif spawn_side == "Left":
		return Vector2(vp_center.x + VPLEFTDIST, vp_center.y + randi_range(VPTOPDIST,VPBOTDIST))
	else: #spawn_side == "Right":
		return Vector2(vp_center.x + VPRIGHTDIST, vp_center.y + randi_range(VPTOPDIST,VPBOTDIST))
