extends CharacterBody2D
@export var speed : int = 260
@export var gravity : int = 1000
var terminal_vel : int = 1000
@export var jump_height : int = 500

@export var water : bool = false
var climbable : bool = false

func _physics_process(delta):
	if !water:
		# Platforming/Land
		if velocity.y < terminal_vel:
			velocity.y += gravity * delta
		else:
			velocity.y = terminal_vel
		velocity.x = Input.get_axis("left", "right") * speed
		if Input.is_action_just_pressed("up") and is_on_floor() == true:
			velocity.y = -jump_height
	else:
		# Swimming/Water
		velocity += Input.get_vector("left", "right", "up", "down") * speed / 4
		velocity -= Vector2(velocity.x / 5, velocity.y / 5)
		if Input.get_axis("down", "up") == 0:
			velocity.y += gravity * delta
	
	if global_position.y > 200 and !water:
		water = true
	if global_position.y < 200 and water:
		water = false
		
	if Input.is_action_pressed("up") and climbable:
		velocity.y -= 25
	
	move_and_slide()

func _dock_climable(_body):
	climbable = true

func _dock_unclimbable(_body):
	climbable = false
