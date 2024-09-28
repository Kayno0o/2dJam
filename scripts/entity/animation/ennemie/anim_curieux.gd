extends Node2D

func _on_curieux_moving():
	$Idle.visible = true
	$Shooting.visible = false

func _on_curieux_shooting():
	$Idle.visible = false
	$Shooting.visible = true
