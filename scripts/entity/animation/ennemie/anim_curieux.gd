extends Node2D

func _on_curieux_moving():
	$Idle.visible = true
	$Scared.visible = false


func _on_curieux_scared():
	$Idle.visible = false
	$Scared.visible = true
