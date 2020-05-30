extends Area2D

var started = false

func _ready():
	add_to_group("RaceItems")

func _on_TimeBoost_body_entered(body):
	if started:
		$AnimationPlayer.play("collected")
		$ExtraTime.play()
		get_tree().call_group("Players", "collect_time")

func flag_start():
	started = true

func booster_collected():
	yield($ExtraTime, "finished")
	queue_free()