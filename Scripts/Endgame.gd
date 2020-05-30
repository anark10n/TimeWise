extends Control

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Levels/Level1.tscn")
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()