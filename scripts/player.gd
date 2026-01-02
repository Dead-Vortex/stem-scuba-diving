extends CharacterBody2D

# Movement Variables
@export var speed : int = 200
@export var gravity : int = 1000
var terminal_vel : int = 1000
@export var jump_height : int = 400

@export var water : bool = false
var climbable : bool = false

# Animation Variables
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var facing : String = "right"

# Interaction Variables
@export var npc : Node2D

# Oxygen Variables
@export var max_oxygen : int = 30
var oxygen : int = max_oxygen
@onready var oxygen_timer : Timer = $OxygenTimer

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta) -> void:
	
	if !water:
		# Platforming/Land
		if velocity.y < terminal_vel:
			velocity.y += gravity * delta
		else:
			velocity.y = terminal_vel
			
		if !npc.is_player_interacting:
			velocity.x = Input.get_axis("left", "right") * speed
			if Input.is_action_just_pressed("up") and is_on_floor() == true:
				velocity.y = -jump_height
		else:
			velocity.x = 0
	
	
	else:
		# Swimming/Water
		velocity += Input.get_vector("left", "right", "up", "down") * speed / 4
		velocity -= Vector2(velocity.x / 5, velocity.y / 5)
		if Input.get_axis("down", "up") == 0:
			velocity.y += gravity / 2.5 * delta
	
	
	
	if global_position.y > 200 and !water:
		water = true
		oxygen_timer.start(1)
	if global_position.y < 200 and water:
		water = false
		oxygen_timer.stop()
		replenish_oxygen()
		
		
	if Input.is_action_pressed("up") and climbable:
		velocity.y -= 25
	
	move_and_slide()

func _process(_delta) -> void:
	if !npc.is_player_interacting:
		if Input.get_axis("left", "right") != 0:
			sprite.play("walk")
		else:
			sprite.play("idle")
		if Input.get_axis("left", "right") == -1 and facing == "right":
			facing = "left"
			sprite.flip_h = true
		if Input.get_axis("left", "right") == 1 and facing == "left":
			facing = "right"
			sprite.flip_h = false
	else:
		sprite.play("idle")

func _on_oxygen_tick() -> void:
	oxygen -= 1
	if oxygen < 1:
		global_position = Vector2(0, 0)
	
func replenish_oxygen() -> void:
	while oxygen < max_oxygen and !water:
		await get_tree().create_timer(0.05).timeout
		oxygen += 1

func _dock_climbable(_body) -> void:
	climbable = true

func _dock_unclimbable(_body) -> void:
	climbable = false
