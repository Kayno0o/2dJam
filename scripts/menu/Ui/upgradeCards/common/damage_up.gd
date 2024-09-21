extends Panel
@export var rarity : PlayerStats.raritys
@export var icon : CompressedTexture2D
@export var description : String
@export var upgrade : PlayerStats.upgrades
@export var statsNumber : float
signal upgrade_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MarginContainer/TextureRect.texture = icon
	$VBoxContainer/MarginContainer2/Label.text = description

func apply_upgrade():
	PlayerStats.add_upgrades(upgrade, statsNumber)
	upgrade_selected.emit()
