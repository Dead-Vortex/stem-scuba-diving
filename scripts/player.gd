extends CharacterBody2D

# Movement Variables
@export var speed : int = 200
@export var swim_speed : int = 200
@export var gravity : int = 1000
var terminal_vel : int = 1000
@export var jump_height : int = 400

var water : bool = false
var climbable : bool = false

# Animation Variables
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var facing : String = "right"

# Interaction Variables
@export var npc1 : Node2D
@export var npc2 : Node2D

# Oxygen Variables
var max_oxygen : int = 30
var oxygen : int = max_oxygen
@onready var oxygen_timer : Timer = $OxygenTimer

var death_pos : Vector2 = Vector2(0, 0)
var death_trash_count : int = 0
@export var trash_spawner : Node

var trash : int = 0
var max_trash : int = 8
var money : int = 0

var vacuum_speed : int = 1
var vacuum_distance : int = 50
var vacuum_toggle : bool = false

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta) -> void:
	
	if !water:
		# Platforming/Land
		if velocity.y < terminal_vel:
			velocity.y += gravity * delta
		else:
			velocity.y = terminal_vel
			
		if !npc1.is_player_interacting and !npc2.is_player_interacting:
			velocity.x = Input.get_axis("left", "right") * speed
			if Input.is_action_just_pressed("jump") and is_on_floor() == true:
				velocity.y = -jump_height
		else:
			velocity.x = 0
	
	
	else:
		# Swimming/Water
		velocity += Input.get_vector("left", "right", "up", "down") * swim_speed / 4
		velocity -= Vector2(velocity.x / 5, velocity.y / 5)
		if Input.get_axis("down", "up") == 0:
			velocity.y += gravity / 2.5 * delta
	
	
	
	if global_position.y > 200 and !water:
		water = true
		oxygen_timer.start(1)
	if global_position.y < 200 and water:
		water = false
		velocity.y -= 200
		oxygen_timer.stop()
		replenish_oxygen()
		
		
	if (Input.is_action_pressed("up") or Input.is_action_pressed("jump")) and climbable:
		velocity.y -= 25
	
	move_and_slide()

func _process(_delta) -> void:
	if !npc1.is_player_interacting and !npc2.is_player_interacting:
		if Input.get_axis("left", "right") != 0:
			sprite.play("walk")
		else:
			sprite.play("idle")
		if Input.get_axis("left", "right") < 0 and facing == "right":
			facing = "left"
			sprite.flip_h = true
		if Input.get_axis("left", "right") > 0 and facing == "left":
			facing = "right"
			sprite.flip_h = false
	else:
		sprite.play("idle")
		
	if Input.is_action_just_pressed("cheat"):
		money += 10000000

func _on_oxygen_tick() -> void:
	oxygen -= 1
	if oxygen < 1:
		death_pos = global_position
		death_trash_count = trash
		global_position = Vector2(0, 120)
		trash = 0
		trash_spawner.lose_trash(death_pos, death_trash_count)
		
	
func replenish_oxygen() -> void:
	while oxygen < max_oxygen and !water:
		await get_tree().create_timer(0.05).timeout
		oxygen += 1

func _dock_climbable(_body) -> void:
	climbable = true

func _dock_unclimbable(_body) -> void:
	climbable = false
