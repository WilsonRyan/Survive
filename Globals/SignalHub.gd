extends Node


signal on_create_enemy_bat
signal on_create_player_bullet

func emit_on_create_enemy_bat() -> void:
	on_create_enemy_bat.emit()

func emit_on_create_player_bullet(pos: Vector2, dir: Vector2) -> void:
	on_create_player_bullet.emit(pos, dir)
