extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed_ratio = PlayerStats.speed / PlayerStats.max_speed * 100
	if speed_ratio < 30:
		play("slow")
	elif speed_ratio >= 30 and speed_ratio <= 80:
		play("medium")
	if speed_ratio > 80:
		play("fast")
	pass
