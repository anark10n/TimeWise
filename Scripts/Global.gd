extends Node

var current_level
var next_level
var level_time
var level_grace

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()