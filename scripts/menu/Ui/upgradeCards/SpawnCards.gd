extends Node

var instance
var cardPicker : Dictionary

var numberOfCards : int

const NUMBER_OF_UPGRADE = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	#creating a dictionary as long as the number of upgrade possible for common cards
	for numberOfCards in Globals.COMMON_CARDS.size() :
		cardPicker[numberOfCards] = numberOfCards
	_pick_the_cards()
	pass # Replace with function body.

func _pick_the_cards():
	for loop in NUMBER_OF_UPGRADE :
		var choosenCards = randi_range(0, Globals.COMMON_CARDS.size())
		while cardPicker.has(choosenCards) == false :
			choosenCards = randi_range(0, Globals.COMMON_CARDS.size())
		print(Globals.COMMON_CARDS[choosenCards])
		var actualScene = load(Globals.COMMON_CARDS[choosenCards])
		var instance = actualScene.instantiate()
		add_child(instance)
		cardPicker.erase(choosenCards)
		pass
	pass
