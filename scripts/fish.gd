extends Node2D
@onready var sprite = get_node("Sprite2D")

var speed : int = randi_range(45, 60)
var dir : String = "left"

func _ready() -> void:
	sprite.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
	var tempscale = randf_range(0.15, 0.25)
	sprite.scale = Vector2(tempscale, tempscale)
	if randi_range(0, 1) == 0:
		dir = "left"
		sprite.flip_h = false
	else:
		dir = "right"
		sprite.flip_h = true
	
func _process(delta: float) -> void:
	global_position.x += (speed if dir == "right" else -speed) * delta
	if (dir == "left" and global_position.x < -7000) or (dir == "right" and global_position.x > 7000):
		queue_free()
