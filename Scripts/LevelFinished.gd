extends Control

onready var level_time_label = get_node("CenterContainer/VBoxContainer/HBoxContainer/LevelTime")
onready var level_grace_label = get_node("CenterContainer/VBoxContainer/HBoxContainer/LevelGrace")

func _ready():
	level_time_label.set_text("Level time " + Global.level_time)
	level_grace_label.set_text("Level grace " + Global.level_grace)

func _process(delta):
	if Input.is_action_pressed("restart"):
		get_tree().change_scene(Global.current_level)
	elif Input.is_action_pressed("ui_accept"):
		get_tree().change_scene(Global.next_level)
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()