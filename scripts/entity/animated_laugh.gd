extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() :
	Globals.ennemy_death.connect(_signal_ennemy_death)
	animation_looped.connect(_stop_animation)
	pass # Replace with function body.

func _signal_ennemy_death() :
	play("Laugh")

func _stop_animation( ) :
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	pass
