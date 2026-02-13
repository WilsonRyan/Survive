extends Control

const UPGRADE_2 = preload("uid://o6h1uvnfqvqa")
const GAMEOVER_4 = preload("uid://bv1p5hiny8qj0")

const HEART_FULL = preload("uid://doe5euit4hoj")
const HEART_EMPTY = preload("uid://cgr4idxxp8v4p")

@onready var h_1: TextureRect = $MarginContainer/VBoxInGame/HBoxHealth/H1
@onready var h_2: TextureRect = $MarginContainer/VBoxInGame/HBoxHealth/H2
@onready var h_3: TextureRect = $MarginContainer/VBoxInGame/HBoxHealth/H3
@onready var timer_label: Label = $MarginContainer/VBoxInGame/TimerLabel
@onready var game_timer: Timer = $GameTimer
@onready var v_box_game_over: VBoxContainer = $MarginContainer/VBoxGameOver
@onready var level_label: Label = $MarginContainer/VBoxInGame/LevelLabel
@onready var xp_progress_bar: TextureProgressBar = $XPProgressBar
@onready var h_box_upgrade_menu: HBoxContainer = $MarginContainer/HBoxUpgradeMenu
@onready var powerup_button: TextureButton = $MarginContainer/HBoxUpgradeMenu/PowerupButton
@onready var powerup_button_2: TextureButton = $MarginContainer/HBoxUpgradeMenu/PowerupButton2
@onready var powerup_button_3: TextureButton = $MarginContainer/HBoxUpgradeMenu/PowerupButton3
@onready var game_music: AudioStreamPlayer = $GameMusic
@onready var sfx: AudioStreamPlayer = $SFX


var _time: float = 0.0
var _player_ref: Player
var _game_paused: bool = false

func _unhandled_input(_event: InputEvent) -> void:
	if _game_paused == true and Input.is_action_just_pressed("start") == true:
		GameManager.load_game_scene()
	else:
		GameManager.load_main_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_takes_damage.connect(on_player_takes_damage)
	SignalHub.on_level_up.connect(on_level_up)
	SignalHub.on_powerup_picked.connect(on_powerup_picked)
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	game_timer.start()
	v_box_game_over.hide()
	h_box_upgrade_menu.hide()
	game_music.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _game_paused == false:
		_time += delta
		timer_label.text = "%.1fs" % _time
	if _player_ref == null: return
	update_xpbar()
	update_level()

func update_xpbar() -> void:
	if _player_ref == null: return
	xp_progress_bar.max_value = _player_ref._level_up_amt
	xp_progress_bar.value = _player_ref._experience

func update_level() -> void:
	if _player_ref == null: return
	level_label.text = "Level: %.0f" % _player_ref._player_level



func on_powerup_picked(_pu: String) -> void:
	h_box_upgrade_menu.hide()
	_game_paused = false
	sfx.stream = UPGRADE_2
	sfx.play()
	powerup_button.setup_button()
	powerup_button_2.setup_button()
	powerup_button_3.setup_button()

func on_level_up() -> void:
	h_box_upgrade_menu.show()
	_game_paused = true

func on_player_takes_damage(_dmg: int) -> void:
	if _player_ref.lives >= 3:
		h_1.texture = HEART_FULL
		h_2.texture = HEART_FULL
		h_3.texture = HEART_FULL
	elif _player_ref.lives == 2:
		h_1.texture = HEART_EMPTY
		h_2.texture = HEART_FULL
		h_3.texture = HEART_FULL
	elif _player_ref.lives == 1:
		h_1.texture = HEART_EMPTY
		h_2.texture = HEART_EMPTY
		h_3.texture = HEART_FULL
	else:
		h_1.texture = HEART_EMPTY
		h_2.texture = HEART_EMPTY
		h_3.texture = HEART_EMPTY
		v_box_game_over.show()
		game_timer.stop()
		game_music.stop()
		sfx.stream = GAMEOVER_4
		sfx.play()
		_game_paused = true


func _on_game_music_finished() -> void:
	game_music.play()
