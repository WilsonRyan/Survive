extends Node


const MAIN = preload("uid://bvo08cjvwj8vd")
const GAME = preload("uid://cn6pdk80w1lo5")

#press enter
func load_game_scene() -> void:
	if Input.is_action_just_pressed("start") == true:
		get_tree().change_scene_to_packed(GAME)

#press escape
func load_main_scene() -> void:
	if Input.is_action_just_pressed("escape") == true:
		get_tree().change_scene_to_packed(MAIN)


func navigate_scenes() -> void:
	if Input.is_action_just_pressed("escape") == true:
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("start") == true:
		GameManager.load_game_scene()
