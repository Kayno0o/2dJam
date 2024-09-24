extends Camera2D

var initialValue: Vector2


func _ready() -> void:
	limit_right = Globals.worldSize.x
	limit_bottom = Globals.worldSize.y
