extends Node


signal on_create_enemy_bat

func emit_on_create_enemy_bat() -> void:
	on_create_enemy_bat.emit()
