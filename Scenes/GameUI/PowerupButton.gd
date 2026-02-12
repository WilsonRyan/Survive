extends TextureButton

class_name PowerupButton

@onready var upgrade_label: Label = $VBoxContainer/upgradeLabel
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect



const UPGRADE_BULLET_PEN = preload("uid://xbgn8euf4d4s")
const UPGRADE_BULLET_SIZE = preload("uid://dih5861ghnv8d")
const UPGRADE_BULLET_SPEED = preload("uid://chq7qq0joj40r")
const UPGRADE_FIRE_RATE = preload("uid://l725kmj2xpw5")
const UPGRADE_PICKUP_RANGE = preload("uid://olcfm2kop1vb")
const UPGRADE_SPEED = preload("uid://bydsirr8ey00f")

var powerups: Dictionary = {
	"Player Speed": UPGRADE_SPEED,
	"Fire Rate": UPGRADE_FIRE_RATE,
	"Bullet Size": UPGRADE_BULLET_SIZE,
	"Bullet Speed": UPGRADE_BULLET_SPEED,
	"Bullet Penetration": UPGRADE_BULLET_PEN,
	"Pickup Range": UPGRADE_PICKUP_RANGE
}

var _player_ref: Player
var _pu: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	setup_button()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func pick_random_powerup(dict: Dictionary) -> Variant:
	var rand_key = dict.keys().pick_random()
	return dict[rand_key]


func setup_button() -> void:
	if _player_ref == null: return
	_pu = _player_ref.powerups.keys().pick_random()
	if _pu == "Bullet Penetration":
		upgrade_label.text = "%s increase by 1." % _pu
	elif _pu == "Fire Rate":
		upgrade_label.text = "%s increase by 10%%." % _pu
	elif _pu == "Pickup Range":
		upgrade_label.text = "%s increase by 20%%." % _pu
	else:
		upgrade_label.text = "%s increase by 10%%." % _pu
	texture_rect.texture = powerups[_pu]


func _on_button_down() -> void:
	modulate = Color(1,1,1,0.5)


func _on_button_up() -> void:
	modulate = Color(1,1,1,1)
	SignalHub.emit_on_powerup_picked(_pu)
