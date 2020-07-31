extends KinematicBody2D

export (int) var speed = 100

onready var animationPlayer = $Mac/AnimationPlayer
var velocity = Vector2()

func _physics_process(delta):
	get_input()
	var animation = "Walk" + direction()
	animationPlayer.play(animation)
	
	velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func direction():
	if Input.is_action_pressed("ui_right"):
		return "Right"
	elif Input.is_action_pressed('ui_left'):
		return "Left"
	elif Input.is_action_pressed('ui_down'):
		return "Down"
	elif Input.is_action_pressed('ui_up'):
		return "Up"
	else:
		return "Idle"
