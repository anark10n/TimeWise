extends "res://Scripts/Character.gd"

const JUMP_SPEED = 1500
const DOUBLE_JUMP = 1500
const DASH_SPEED = SPEED * 14
const ACCELERATION = 200
var extra_jump = true
onready var countdown_timer = get_node("../GUI/Control/TextureRect/HBoxContainer/VBoxContainer2/Countdown")
var race_start = false
var time_now = 0
var time_start = 0
onready var game_timer = get_node("../GUI/Control/TextureRect/HBoxContainer/VBoxContainer/LapTime")

signal animate

func _ready():
	add_to_group("Players")

func _physics_process(delta):
	if race_start:
		update_time()
		
	apply_gravity()
	jump()
	double_jump()
	move(delta)
	animate(delta)
	move_and_slide(motion, UP)

func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
		
	if is_on_floor():
		motion.y = 1
		extra_jump = true
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func jump():
	if is_on_floor() and Input.is_action_just_pressed("ui_jump"):
		motion.y = -JUMP_SPEED
		$JumpSFX.play()

func double_jump():
	if not is_on_floor() and Input.is_action_just_pressed("ui_jump") and extra_jump:
		extra_jump = false
		motion.y = -DOUBLE_JUMP
		$JumpSFX.play()

func move(delta):
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		$Camera2D.position.x = -600
		if is_on_floor():
			motion.x = clamp(motion.x - ACCELERATION * delta, -MAX_SPEED, -SPEED)
		else:
			motion.x = clamp(motion.x + ACCELERATION * delta, -MAX_SPEED, -SPEED)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$Camera2D.position.x = 600
		if is_on_floor():
			motion.x = clamp(motion.x + ACCELERATION * delta, SPEED, MAX_SPEED)
		else:
			motion.x = clamp(motion.x - ACCELERATION * delta, SPEED, MAX_SPEED)
	else:
		motion.x = 0

func animate(delta):
	emit_signal("animate", motion, delta)
	
func update_time():
	var lc_minutes = $LevelClearance.time_left / 60
	var time_remaining = "%02d:%02.1f" % [lc_minutes, $LevelClearance.time_left]
	countdown_timer.set_text(time_remaining)
	
	time_now = OS.get_system_time_msecs()
	var elapsed = time_now - time_start
	var lt_minutes = elapsed / 60000
	var lt_seconds = elapsed / 1000
	var lt_millisecs = elapsed % 1000
	var lt_milsec = str(lt_millisecs)
	var str_elapsed = "%02d:%02d.%s" % [lt_minutes, lt_seconds, lt_milsec[0]]
	game_timer.set_text(str_elapsed)

func collect_time():
	$LevelClearance.wait_time = $LevelClearance.time_left + 3
	$LevelClearance.start()

func start_clocks():
	if not race_start:
		race_start = true
		$LevelClearance.start()
		time_start = OS.get_system_time_msecs()

func get_countdown_timer():
	return countdown_timer.text

func get_game_timer():
	return game_timer.text

func _on_LevelClearance_timeout():
	get_tree().change_scene("res://Levels/GameOver.tscn")
