extends Bullet

var _bullet_pen: float = 1.0

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	_bullet_pen = _player_ref.powerups["Bullet Penetration"]
	rotate(direction.angle())
	speed = _player_ref.powerups["Bullet Speed"]
	scale = scale * _player_ref.powerups["Bullet Size"]/100
	super()


func _on_area_entered(area: Area2D) -> void:
	_bullet_pen += -1
	if _bullet_pen <= 0:
		super(area)
