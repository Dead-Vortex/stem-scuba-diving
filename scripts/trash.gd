extends Node2D

var dir : String = "up"
var init_height : float = 0
var float_distance : float = 10
var float_speed : float = 1

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	init_height = global_position.y
	float_speed = randf_range(0.5, 2)

func _process(delta: float) -> void:
	global_position.y += (-float_distance if dir == "up" else float_distance) * delta * float_speed
	if init_height - float_distance > global_position.y and dir == "up":
		dir = "down"
	elif init_height + float_distance < global_position.y and dir == "down":
		dir = "up"

func _on_trash_collected(body: Node2D) -> void:
	if body.name == "Player":
		body.trash += 1
		queue_free()
