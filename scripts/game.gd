extends Control

func _ready() -> void:
	Globals.set_game_start_time()
	Globals.ui_node = $UiCanvas/Ui

func _process(_delta: float) -> void:
	pass

func _draw() -> void:
	pass
