extends VBoxContainer


@onready var max_speed_label: Label = $MaxSpeed/Value
@onready var acceleration_label: Label = $Acceleration/Value
@onready var rotation_label: Label = $Rotation/Value
@onready var damage_label: Label = $Damage/Value
@onready var friction_label: Label = $Friction/Value
@onready var size_label: Label = $Size/Value

func _draw():
	max_speed_label.text = str(PlayerStats.max_speed)
	acceleration_label.text = str(PlayerStats.acceleration)
	rotation_label.text = str(PlayerStats.rotation_velocity * 10)
	damage_label.text = str(PlayerStats.damage)
	friction_label.text = str(PlayerStats.friction * 10_000)
	size_label.text = str(PlayerStats.size * 100)
