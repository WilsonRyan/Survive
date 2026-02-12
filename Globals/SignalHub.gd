extends Node


signal on_create_enemy_bat
signal on_create_player_bullet
signal on_player_takes_damage
signal on_xp_gained
signal on_create_xp

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
