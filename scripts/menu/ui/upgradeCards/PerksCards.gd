@tool

extends Panel

@export var rarity: PlayerStats.raritys
@export var icon: AtlasTexture
@export var stat_description: String
@export var description: String
@export var upgrade: PlayerStats.upgrades
@export var stats_number: float

# Update UI elements when properties change
func _set_ui():
	$VBoxContainer/MarginContainer/TextureRect.texture = icon
	$VBoxContainer/MarginContainer2/Label.text = stat_description
	$VBoxContainer/MarginContainer3/Label.text = description

	var style_box = StyleBoxFlat.new()

	style_box.border_color = Color(0, 0, 0, 1)

	style_box.border_width_bottom = 3
	style_box.border_width_top = 3
	style_box.border_width_left = 3
	style_box.border_width_right = 3

	style_box.corner_radius_bottom_left = 6
	style_box.corner_radius_bottom_right = 6
	style_box.corner_radius_top_left = 6
	style_box.corner_radius_top_right = 6

	if rarity == PlayerStats.raritys.COMMON:
		style_box.bg_color = Color(0.255, 0.184, 0.086, 0.8)
	elif rarity == PlayerStats.raritys.RARE:
		style_box.bg_color = Color(0.114, 0.16, 0.441, 0.8)
	elif rarity == PlayerStats.raritys.LEGENDARY:
		style_box.bg_color = Color(0.875, 0.902, 0.251, 0.8)

	add_theme_stylebox_override("panel", style_box)


func _ready():
	_set_ui()

# Called every frame in the editor when @tool is active
func _process(_delta: float):
	if Engine.is_editor_hint():
		_set_ui()

func apply_upgrade():
	
	# apply the upgrade to the player
	PlayerStats.add_upgrades(upgrade, stats_number)
