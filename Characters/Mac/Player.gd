extends KinematicBody2D

export (int) var speed = 50
onready var animationSprite = $Sprite
onready var raycast = $Raycast2D

var velocity := Vector2.ZERO
var last_direction = Vector2(0, 1) # Saves direction to know where they are facing

func _input(event):
	if event.is_action_pressed("continue_dialogue"):
		var target : StaticBody2D = raycast.get_collider()
		if target and target.is_in_group("NPC"):
			target.talk()

func _physics_process(delta):
	move(delta)

func move(delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	direction = direction.normalized()
	var movement = speed * direction * delta
	
	if direction != Vector2.ZERO:
		raycast.cast_to = direction.normalized() * 8
		
	move_and_collide(movement)
	animates_player(direction)

func animates_player(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		last_direction = 0.5 * last_direction + 0.5 * direction

		var animation = "Walk" + get_animation_direction(last_direction)

		$Sprite.frames.set_animation_speed(animation, 2 + 8 * last_direction.length())
		$Sprite.play(animation)

	else:
		var animation = "Idle" + get_animation_direction(last_direction)
		$Sprite.play(animation)

func get_animation_direction(direction: Vector2) -> String:
	var norm_direction = direction.normalized()
	
	if norm_direction.y >= 0.707:
		return "Down"
	elif norm_direction.y <= -0.707:
		return "Up"
	elif norm_direction.x <= -0.707:
		return "Left"
	elif norm_direction.x >= 0.707:
		return "Right"
	
	return "Down"
