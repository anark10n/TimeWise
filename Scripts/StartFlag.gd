extends "res://Scripts/Flag.gd"

func _ready():
	$AnimatedSprite.set_animation("red_flag")

func _on_StartFlag_body_entered(body):
	if not started:
		get_tree().call_group("RaceItems", "flag_start")
		get_tree().call_group("Players", "start_clocks")
		$AnimatedSprite.set_animation("green_flag")
