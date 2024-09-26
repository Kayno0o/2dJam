extends Panel
@export var rarity: PlayerStats.raritys
@export var icon: AtlasTexture
@export var stat_description: String
@export var description: String
@export var upgrade: PlayerStats.upgrades
@export var stats_number: float
signal upgrade_selected


func _ready():
	
	# set up the upgrade card
	$VBoxContainer/MarginContainer/TextureRect.texture = icon
	$VBoxContainer/MarginContainer2/Label.text = stat_description
	$VBoxContainer/MarginContainer3/Label.text = description

func apply_upgrade():
	
	# apply the upgrade to the player
	PlayerStats.add_upgrades(upgrade, stats_number)
	upgrade_selected.emit()
