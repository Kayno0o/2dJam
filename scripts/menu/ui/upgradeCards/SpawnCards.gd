extends Node

var instance

var common_card_picker: Dictionary
var rare_card_picker: Dictionary
var legendary_card_picker: Dictionary

const NUMBER_OF_UPGRADE = 3

const COMMON_CARDS = ["res://scenes/upgradeCards/common/accelerationUp.tscn", "res://scenes/upgradeCards/common/damageUp.tscn", "res://scenes/upgradeCards/common/maxSpeed.tscn", "res://scenes/upgradeCards/common/momentumUp.tscn", "res://scenes/upgradeCards/common/rotationSpeedUp.tscn", "res://scenes/upgradeCards/common/sizeUp.tscn"]
const RARE_CARDS = ["res://scenes/upgradeCards/rare/accelerationUp.tscn", "res://scenes/upgradeCards/rare/damageUp.tscn", "res://scenes/upgradeCards/rare/maxSpeed.tscn", "res://scenes/upgradeCards/rare/momentumUp.tscn", "res://scenes/upgradeCards/rare/rotationSpeedUp.tscn", "res://scenes/upgradeCards/rare/sizeUp.tscn"]
const LEGENDARY_CARDS = ["res://scenes/upgradeCards/legendary/accelerationUp.tscn", "res://scenes/upgradeCards/legendary/damageUp.tscn", "res://scenes/upgradeCards/legendary/maxSpeed.tscn", "res://scenes/upgradeCards/legendary/momentumUp.tscn", "res://scenes/upgradeCards/legendary/rotationSpeedUp.tscn", "res://scenes/upgradeCards/legendary/sizeUp.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#creating a dictionary as long as the number of upgrade possible for common cards
	for number_of_cards in COMMON_CARDS.size():
		common_card_picker[number_of_cards] = number_of_cards
	rare_card_picker = common_card_picker.duplicate()
	legendary_card_picker = common_card_picker.duplicate()
	_pick_the_cards()

func _pick_the_cards():
	for loop in NUMBER_OF_UPGRADE:
		var choosen_cards
		var rarity = randf_range(0, 1.0)
		var actual_scene

		# 5%
		if rarity < 0.05:
			choosen_cards = randi_range(0, LEGENDARY_CARDS.size())
			while legendary_card_picker.has(choosen_cards) == false:
				choosen_cards = randi_range(0, LEGENDARY_CARDS.size())
			if legendary_card_picker.has(choosen_cards) == true:
				actual_scene = load(LEGENDARY_CARDS[choosen_cards])
				legendary_card_picker.erase(choosen_cards)

		# 20%
		elif rarity < 0.25:
			choosen_cards = randi_range(0, RARE_CARDS.size())
			while rare_card_picker.has(choosen_cards) == false:
				choosen_cards = randi_range(0, RARE_CARDS.size())
			if rare_card_picker.has(choosen_cards) == true:
				actual_scene = load(RARE_CARDS[choosen_cards])
				rare_card_picker.erase(choosen_cards)

		# 75%
		else:
			choosen_cards = randi_range(0, COMMON_CARDS.size())
			while common_card_picker.has(choosen_cards) == false:
				choosen_cards = randi_range(0, COMMON_CARDS.size())
			if common_card_picker.has(choosen_cards) == true:
				actual_scene = load(COMMON_CARDS[choosen_cards])
				common_card_picker.erase(choosen_cards)
		
		instance = actual_scene.instantiate()
		add_child(instance)
		pass
