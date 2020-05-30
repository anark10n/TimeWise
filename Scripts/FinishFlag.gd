extends "res://Scripts/Flag.gd"

onready var player_state = get_node("../Player")

func _on_FinishFlag_body_entered(body):
	print("Entered")
	if started:
		Global.level_time = player_state.get_countdown_timer()
		Global.level_grace = player_state.get_game_timer()
		get_tree().change_scene("res://Levels/LevelFinished.tscn")
