extends AnimatedSprite
var animation_speed = get_speed_scale()

func _on_Player_animate(motion, delta):
	if motion.y < 0:
		play("jump")
	elif motion.x > 0:
		flip_h = false
		animation_speed += 1 * delta
		set_speed_scale(clamp(animation_speed, 1, 3))
		play("walk")
	elif motion.x < 0:
		flip_h = true
		animation_speed += 1 * delta
		set_speed_scale(clamp(animation_speed, 1, 3))
		play("walk")
	else:
		animation_speed = 1
		set_speed_scale(animation_speed)
		play("idle")
