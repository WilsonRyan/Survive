extends Control


@onready var ps_label: Label = $TextureRect/MarginContainer/VBoxContainer/PSLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enter_sprite_2d: Sprite2D = $EnterSprite2D


func _unhandled_input(_event: InputEvent) -> void:
	GameManager.navigate_scenes()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ps_label.text = " "
	enter_sprite_2d.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "title":
		ps_label.text = "Press 'Enter' to start"
		enter_sprite_2d.show()
		animation_player.play("press_enter")
