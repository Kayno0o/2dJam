extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speedRatio = PlayerStats.speed / PlayerStats.maxSpeed * 100
	if speedRatio < 30 :
		play("slow")
	elif speedRatio >= 30 and speedRatio <= 80 :
		play("medium")
	if speedRatio > 80 :
		play("fast")
	pass
