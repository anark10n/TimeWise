extends Area2D

var started = false

func _ready():
	$AnimatedSprite.play()
	add_to_group("RaceItems")

func flag_start():
	started = true