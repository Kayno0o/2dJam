extends Area2D

var healing_targets : Array
var healing_amount : int = 1
var healing_cooldown = 2.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healing_cooldown -= delta
	if healing_cooldown <= 0 :
		for heal in healing_targets :
			heal.heal.emit(healing_amount, heal.max_health)

func _on_body_entered(body):
	healing_targets.append(body)

func _on_body_exited(body):
	healing_targets.erase(body)
