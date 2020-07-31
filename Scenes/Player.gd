extends KinematicBody2D

export (int) var speed = 100

onready var animationPlayer = $Mac/AnimationPlayer
var velocity = Vector2()

func _physics_process(delta):
	animationPlayer.play("Idle")
	get_input()
	velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		animationPlayer.play("WalkDown")
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
