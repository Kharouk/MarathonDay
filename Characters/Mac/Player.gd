extends KinematicBody2D

export (int) var speed = 4000

onready var animationSprite = $AnimatedSprite

var velocity = Vector2()

func _physics_process(delta):
	get_input_vector()
	var animation = "Walk" + direction()
	animationSprite.play(animation)
	
	velocity = velocity * delta
	
	velocity = move_and_slide(velocity)

func get_input_vector():
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
