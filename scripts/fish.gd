extends Node2D
@onready var sprite = get_node("Sprite2D")

func _ready() -> void:
	sprite.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
	
func _process(delta: float) -> void:
	global_position.x -= 50 * delta
