extends "res://Scripts/GameState.gd"

func _ready():
	Global.current_level = "res://Levels/Level2.tscn"
	Global.next_level = "res://Levels/Endgame.tscn"