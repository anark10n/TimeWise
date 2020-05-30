extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(Global.current_level)
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_RestartButton_pressed():
	get_tree().change_scene(Global.current_level)
