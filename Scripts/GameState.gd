extends Node2D

func _ready():
	add_to_group("Gamestate")

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")