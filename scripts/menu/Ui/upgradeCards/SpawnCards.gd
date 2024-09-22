extends Node

var instance

var commonCardPicker : Dictionary
var rareCardPicker : Dictionary
var legendaryCardPicker : Dictionary

var numberOfCards : int

const NUMBER_OF_UPGRADE = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	#creating a dictionary as long as the number of upgrade possible for common cards
	for numberOfCards in Globals.COMMON_CARDS.size() :
		commonCardPicker[numberOfCards] = numberOfCards
	rareCardPicker = commonCardPicker.duplicate()
	legendaryCardPicker = commonCardPicker.duplicate()
	_pick_the_cards()
	pass # Replace with function body.

func _pick_the_cards():
	for loop in NUMBER_OF_UPGRADE :
		var choosenCards
		var rarity = randf_range(0, 1.0)
		var actualScene
		print(commonCardPicker)
		
		print(rarity)
		if rarity > 0.4 :
			choosenCards = randi_range(0, Globals.COMMON_CARDS.size())
			while commonCardPicker.has(choosenCards) == false :
				choosenCards = randi_range(0, Globals.COMMON_CARDS.size())
			if commonCardPicker.has(choosenCards) == true :
				print(Globals.COMMON_CARDS[choosenCards])
				actualScene = load(Globals.COMMON_CARDS[choosenCards])
				commonCardPicker.erase(choosenCards)

		elif rarity <= 0.4 and rarity > 0.1 :
			choosenCards = randi_range(0, Globals.RARE_CARDS.size())
			while rareCardPicker.has(choosenCards) == false :
				choosenCards = randi_range(0, Globals.RARE_CARDS.size())
			if rareCardPicker.has(choosenCards) == true :
				print(Globals.RARE_CARDS[choosenCards])
				actualScene = load(Globals.RARE_CARDS[choosenCards])
				rareCardPicker.erase(choosenCards)
		
		else :
			choosenCards = randi_range(0, Globals.LEGENDARY_CARDS.size())
			while legendaryCardPicker.has(choosenCards) == false :
				choosenCards = randi_range(0, Globals.LEGENDARY_CARDS.size())
			if legendaryCardPicker.has(choosenCards) == true :
				print(Globals.LEGENDARY_CARDS[choosenCards])
				actualScene = load(Globals.LEGENDARY_CARDS[choosenCards])
				legendaryCardPicker.erase(choosenCards)
		
		instance = actualScene.instantiate()
		add_child(instance)
		pass
	pass
