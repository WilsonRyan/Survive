extends Node


signal on_create_enemy_bat
signal on_create_player_bullet
signal on_player_takes_damage

func emit_on_create_enemy_bat() -> void:
	on_create_enemy_bat.emit()

func emit_on_create_player_bullet(pos: Vector2, dir: Vector2) -> void:
	on_create_player_bullet.emit(pos, dir)

func emit_on_player_takes_damage(dmg: int) -> void:
	on_player_takes_damage.emit(dmg)
