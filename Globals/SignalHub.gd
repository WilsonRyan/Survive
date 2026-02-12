extends Node


signal on_create_enemy_bat
signal on_create_player_bullet
signal on_player_takes_damage
signal on_xp_gained
signal on_create_xp
signal on_level_up
signal on_powerup_picked

func emit_on_powerup_picked(pu: String) -> void:
	on_powerup_picked.emit(pu)

func emit_on_level_up() -> void:
	on_level_up.emit()

func emit_on_create_xp(pos: Vector2) -> void:
	on_create_xp.emit(pos)

func emit_on_create_enemy_bat() -> void:
	on_create_enemy_bat.emit()

func emit_on_create_player_bullet(pos: Vector2, dir: Vector2) -> void:
	on_create_player_bullet.emit(pos, dir)

func emit_on_player_takes_damage(dmg: int) -> void:
	on_player_takes_damage.emit(dmg)

func emit_on_xp_gained() -> void:
	on_xp_gained.emit()
